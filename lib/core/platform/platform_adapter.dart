import '../actions/action_result.dart';
import '../actions/system_action.dart';

abstract interface class PlatformAdapter {
  String get platformName;

  Future<Set<String>> getCapabilities();

  Future<ActionResult> execute(SystemAction action);

  Future<void> cancel(String commandId);
}
