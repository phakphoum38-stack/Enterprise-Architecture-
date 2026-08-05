import '../actions/system_action.dart';

class RiskClassifier {
  const RiskClassifier();

  ActionRisk classify(String actionName) {
    if (_restrictedActions.contains(actionName)) {
      return ActionRisk.restricted;
    }
    if (_confirmationActions.contains(actionName)) {
      return ActionRisk.confirmationRequired;
    }
    return ActionRisk.safe;
  }

  static const Set<String> _confirmationActions = <String>{
    'screen_recording.start',
    'application.close',
    'application.restart',
    'system.setting.change',
    'file.move_many',
    'device.shutdown',
    'device.restart',
  };

  static const Set<String> _restrictedActions = <String>{
    'security.disable',
    'permission.bypass',
    'file.delete_permanently',
    'shell.execute_unrestricted',
  };
}
