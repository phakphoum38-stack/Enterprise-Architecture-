import '../actions/action_result.dart';

abstract interface class RecorderService {
  Future<ActionResult> start({
    required String commandId,
    bool microphone = false,
    bool systemAudio = false,
  });

  Future<ActionResult> stop({required String commandId});

  Future<ActionResult> captureScreenshot({required String commandId});

  Future<void> cancel(String commandId);
}
