import '../actions/system_action.dart';
import '../security/risk_classifier.dart';

/// Converts a small, deterministic set of Thai/English commands into actions.
///
/// This parser is intentionally rule-based for the foundation phase. A future
/// AI provider can produce the same [SystemAction] contract without changing
/// the application or platform layers.
class CommandParser {
  const CommandParser(this._riskClassifier);

  final RiskClassifier _riskClassifier;

  SystemAction parse(String rawCommand) {
    final command = rawCommand.trim();
    if (command.isEmpty) {
      throw const FormatException('Command must not be empty.');
    }

    final normalized = command.toLowerCase();
    final actionName = switch (normalized) {
      final value when value.contains('เริ่มบันทึก') ||
          value.contains('เริ่มอัด') ||
          value.contains('start recording') =>
        'screen_recording.start',
      final value when value.contains('หยุดบันทึก') ||
          value.contains('หยุดอัด') ||
          value.contains('stop recording') =>
        'screen_recording.stop',
      final value when value.contains('ถ่ายภาพหน้าจอ') ||
          value.contains('screenshot') =>
        'screenshot.capture',
      final value when value.startsWith('เปิด ') || value.startsWith('open ') =>
        'application.open',
      final value when value.startsWith('ปิด ') || value.startsWith('close ') =>
        'application.close',
      final value when value.contains('ลบถาวร') ||
          value.contains('delete permanently') =>
        'file.delete_permanently',
      _ => 'command.unsupported',
    };

    final parameters = <String, Object?>{
      'rawCommand': command,
      if (actionName == 'screen_recording.start')
        'microphone': normalized.contains('ไมค์') ||
            normalized.contains('ไมโครโฟน') ||
            normalized.contains('microphone'),
    };

    return SystemAction(
      id: 'cmd_${DateTime.now().microsecondsSinceEpoch}',
      name: actionName,
      parameters: parameters,
      risk: _riskClassifier.classify(actionName),
    );
  }
}
