import '../actions/action_result.dart';
import '../actions/system_action.dart';
import 'platform_adapter.dart';

class MockPlatformAdapter implements PlatformAdapter {
  MockPlatformAdapter({Set<String>? capabilities})
      : _capabilities = capabilities ??
            <String>{
              'screen_recording.start',
              'screen_recording.stop',
              'screenshot.capture',
              'application.open',
              'application.close',
            };

  final Set<String> _capabilities;
  final Set<String> _cancelled = <String>{};

  @override
  String get platformName => 'mock';

  @override
  Future<Set<String>> getCapabilities() async => Set<String>.unmodifiable(_capabilities);

  @override
  Future<ActionResult> execute(SystemAction action) async {
    if (_cancelled.contains(action.id)) {
      return ActionResult(
        commandId: action.id,
        success: false,
        message: 'คำสั่งถูกยกเลิก',
        errorCode: 'command_cancelled',
      );
    }
    if (!_capabilities.contains(action.name)) {
      return ActionResult(
        commandId: action.id,
        success: false,
        message: 'แพลตฟอร์มนี้ยังไม่รองรับ ${action.name}',
        errorCode: 'unsupported_capability',
      );
    }
    return ActionResult(
      commandId: action.id,
      success: true,
      message: 'จำลองการทำงานสำเร็จ: ${action.name}',
      details: <String, Object?>{'platform': platformName},
    );
  }

  @override
  Future<void> cancel(String commandId) async {
    _cancelled.add(commandId);
  }
}
