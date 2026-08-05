import 'package:flutter_test/flutter_test.dart';
import 'package:phakphum_ai_system_assistant/core/commands/command_parser.dart';
import 'package:phakphum_ai_system_assistant/core/security/risk_classifier.dart';

void main() {
  const parser = CommandParser(RiskClassifier());

  test('parses Thai screen recording command', () {
    final action = parser.parse('เริ่มอัดหน้าจอพร้อมไมโครโฟน');

    expect(action.name, 'screen_recording.start');
    expect(action.parameters['microphone'], isTrue);
    expect(action.requiresConfirmation, isTrue);
  });

  test('parses open application as safe action', () {
    final action = parser.parse('เปิด Visual Studio Code');

    expect(action.name, 'application.open');
    expect(action.requiresConfirmation, isFalse);
  });

  test('rejects empty commands', () {
    expect(() => parser.parse('   '), throwsFormatException);
  });
}
