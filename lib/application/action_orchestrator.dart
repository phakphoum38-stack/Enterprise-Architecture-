import '../core/actions/action_result.dart';
import '../core/actions/system_action.dart';
import '../core/control/emergency_stop_controller.dart';
import '../core/platform/platform_adapter.dart';
import '../core/security/permission_engine.dart';

class ActionOrchestrator {
  const ActionOrchestrator({
    required PlatformAdapter platformAdapter,
    required PermissionEngine permissionEngine,
    required EmergencyStopController emergencyStopController,
  })  : _platformAdapter = platformAdapter,
        _permissionEngine = permissionEngine,
        _emergencyStopController = emergencyStopController;

  final PlatformAdapter _platformAdapter;
  final PermissionEngine _permissionEngine;
  final EmergencyStopController _emergencyStopController;

  Future<ActionResult> execute(
    SystemAction action, {
    bool userConfirmed = false,
  }) async {
    _emergencyStopController.throwIfStopped();

    final permission = _permissionEngine.evaluate(action);
    if (!permission.allowed) {
      return ActionResult(
        commandId: action.id,
        success: false,
        message: permission.reason,
        errorCode: 'ACTION_BLOCKED',
      );
    }

    if (permission.requiresConfirmation && !userConfirmed) {
      return ActionResult(
        commandId: action.id,
        success: false,
        message: permission.reason,
        errorCode: 'CONFIRMATION_REQUIRED',
      );
    }

    final capabilities = await _platformAdapter.getCapabilities();
    if (!capabilities.contains(action.name)) {
      return ActionResult(
        commandId: action.id,
        success: false,
        message: '${_platformAdapter.platformName} does not support ${action.name}.',
        errorCode: 'UNSUPPORTED_ACTION',
      );
    }

    _emergencyStopController.throwIfStopped();
    return _platformAdapter.execute(action);
  }

  Future<void> cancel(String commandId) =>
      _platformAdapter.cancel(commandId);
}
