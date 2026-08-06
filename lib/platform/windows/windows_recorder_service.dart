import '../../core/actions/action_result.dart';
import '../../core/recorder/recorder_service.dart';

/// Foundation implementation for the Windows recorder boundary.
///
/// Native Windows Graphics Capture and audio integration will replace the
/// placeholder results without changing the application or presentation layers.
class WindowsRecorderService implements RecorderService {
  final Set<String> _cancelledCommands = <String>{};

  @override
  Future<ActionResult> start({
    required String commandId,
    bool microphone = false,
    bool systemAudio = false,
  }) async {
    if (_cancelledCommands.contains(commandId)) {
      return _cancelled(commandId);
    }

    return ActionResult(
      commandId: commandId,
      success: false,
      message: 'Windows screen capture native bridge is not connected yet.',
      errorCode: 'WINDOWS_NATIVE_BRIDGE_PENDING',
      details: <String, Object?>{
        'microphone': microphone,
        'systemAudio': systemAudio,
      },
    );
  }

  @override
  Future<ActionResult> stop({required String commandId}) async {
    if (_cancelledCommands.contains(commandId)) {
      return _cancelled(commandId);
    }

    return ActionResult(
      commandId: commandId,
      success: false,
      message: 'No native Windows recording session is active.',
      errorCode: 'NO_ACTIVE_RECORDING',
    );
  }

  @override
  Future<ActionResult> captureScreenshot({required String commandId}) async {
    if (_cancelledCommands.contains(commandId)) {
      return _cancelled(commandId);
    }

    return ActionResult(
      commandId: commandId,
      success: false,
      message: 'Windows screenshot native bridge is not connected yet.',
      errorCode: 'WINDOWS_NATIVE_BRIDGE_PENDING',
    );
  }

  @override
  Future<void> cancel(String commandId) async {
    _cancelledCommands.add(commandId);
  }

  ActionResult _cancelled(String commandId) {
    return ActionResult(
      commandId: commandId,
      success: false,
      message: 'The Windows recorder command was cancelled.',
      errorCode: 'COMMAND_CANCELLED',
    );
  }
}
