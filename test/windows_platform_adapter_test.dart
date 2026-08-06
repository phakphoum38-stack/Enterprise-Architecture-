import 'package:flutter_test/flutter_test.dart';
import 'package:phakphum_ai_system_assistant/core/actions/system_action.dart';
import 'package:phakphum_ai_system_assistant/platform/windows/windows_platform_adapter.dart';

void main() {
  test('reports recorder capabilities', () async {
    final adapter = WindowsPlatformAdapter();

    final capabilities = await adapter.getCapabilities();

    expect(capabilities, contains('screen_recording.start'));
    expect(capabilities, contains('screen_recording.stop'));
    expect(capabilities, contains('screenshot.capture'));
  });

  test('returns pending bridge result before native integration', () async {
    final adapter = WindowsPlatformAdapter();
    const action = SystemAction(
      id: 'cmd_windows_test',
      name: 'screen_recording.start',
      parameters: <String, Object?>{'microphone': true},
      risk: ActionRisk.confirmationRequired,
    );

    final result = await adapter.execute(action);

    expect(result.success, isFalse);
    expect(result.errorCode, 'WINDOWS_NATIVE_BRIDGE_PENDING');
    expect(result.details['microphone'], isTrue);
  });
}
