import 'package:flutter_test/flutter_test.dart';
import 'package:phakphum_ai_system_assistant/core/actions/action_result.dart';
import 'package:phakphum_ai_system_assistant/core/actions/system_action.dart';
import 'package:phakphum_ai_system_assistant/core/audit/activity_log.dart';

void main() {
  test('records action results in order', () {
    final ActivityLog log = ActivityLog();
    const SystemAction action = SystemAction(
      id: 'cmd_1',
      name: 'screenshot.capture',
      parameters: <String, Object?>{},
      risk: ActionRisk.safe,
    );
    const ActionResult result = ActionResult(
      commandId: 'cmd_1',
      success: true,
      message: 'ok',
    );

    log.record(action, result);

    expect(log.entries, hasLength(1));
    expect(log.entries.single.action.name, 'screenshot.capture');
    expect(log.entries.single.result.success, isTrue);
  });

  test('clear removes all entries', () {
    final ActivityLog log = ActivityLog();
    const SystemAction action = SystemAction(
      id: 'cmd_1',
      name: 'application.open',
      parameters: <String, Object?>{},
      risk: ActionRisk.safe,
    );
    const ActionResult result = ActionResult(
      commandId: 'cmd_1',
      success: true,
      message: 'ok',
    );

    log.record(action, result);
    log.clear();

    expect(log.entries, isEmpty);
  });
}
