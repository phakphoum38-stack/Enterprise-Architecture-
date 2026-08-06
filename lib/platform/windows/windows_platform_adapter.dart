import '../../core/actions/action_result.dart';
import '../../core/actions/system_action.dart';
import '../../core/platform/platform_adapter.dart';
import 'windows_recorder_service.dart';

class WindowsPlatformAdapter implements PlatformAdapter {
  WindowsPlatformAdapter({WindowsRecorderService? recorderService})
      : _recorderService = recorderService ?? WindowsRecorderService();

  final WindowsRecorderService _recorderService;

  static const Set<String> _capabilities = <String>{
    'screen_recording.start',
    'screen_recording.stop',
    'screenshot.capture',
  };

  @override
  String get platformName => 'windows';

  @override
  Future<Set<String>> getCapabilities() async =>
      Set<String>.unmodifiable(_capabilities);

  @override
  Future<ActionResult> execute(SystemAction action) {
    return switch (action.name) {
      'screen_recording.start' => _recorderService.start(
          commandId: action.id,
          microphone: action.parameters['microphone'] == true,
          systemAudio: action.parameters['systemAudio'] == true,
        ),
      'screen_recording.stop' =>
        _recorderService.stop(commandId: action.id),
      'screenshot.capture' =>
        _recorderService.captureScreenshot(commandId: action.id),
      _ => Future<ActionResult>.value(
          ActionResult(
            commandId: action.id,
            success: false,
            message: 'Windows does not support ${action.name} yet.',
            errorCode: 'UNSUPPORTED_ACTION',
          ),
        ),
    };
  }

  @override
  Future<void> cancel(String commandId) => _recorderService.cancel(commandId);
}
