import 'package:flutter_test/flutter_test.dart';
import 'package:phakphum_ai_system_assistant/core/actions/system_action.dart';
import 'package:phakphum_ai_system_assistant/core/security/permission_engine.dart';

void main() {
  const engine = PermissionEngine();

  test('allows safe actions without confirmation', () {
    const action = SystemAction(
      id: '1',
      name: 'application.open',
      parameters: <String, Object?>{},
      risk: ActionRisk.safe,
    );

    final decision = engine.evaluate(action);
    expect(decision.allowed, isTrue);
    expect(decision.requiresConfirmation, isFalse);
  });

  test('requires confirmation for sensitive actions', () {
    const action = SystemAction(
      id: '2',
      name: 'screen_recording.start',
      parameters: <String, Object?>{},
      risk: ActionRisk.confirmationRequired,
    );

    final decision = engine.evaluate(action);
    expect(decision.allowed, isTrue);
    expect(decision.requiresConfirmation, isTrue);
  });

  test('blocks restricted actions', () {
    const action = SystemAction(
      id: '3',
      name: 'security.disable',
      parameters: <String, Object?>{},
      risk: ActionRisk.restricted,
    );

    final decision = engine.evaluate(action);
    expect(decision.allowed, isFalse);
  });
}
