import 'dart:async';

/// Broadcasts cancellation to long-running application and platform actions.
class EmergencyStopController {
  EmergencyStopController();

  final StreamController<void> _stopController =
      StreamController<void>.broadcast(sync: true);

  bool _isStopped = false;

  bool get isStopped => _isStopped;

  Stream<void> get onStop => _stopController.stream;

  void trigger() {
    if (_isStopped) return;
    _isStopped = true;
    _stopController.add(null);
  }

  void reset() {
    _isStopped = false;
  }

  void throwIfStopped() {
    if (_isStopped) {
      throw const OperationCancelledException();
    }
  }

  Future<void> dispose() => _stopController.close();
}

class OperationCancelledException implements Exception {
  const OperationCancelledException();

  @override
  String toString() => 'OperationCancelledException: emergency stop triggered';
}
