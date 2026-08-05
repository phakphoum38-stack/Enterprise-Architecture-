import 'package:flutter_test/flutter_test.dart';
import 'package:phakphum_ai_system_assistant/core/actions/system_action.dart';
import 'package:phakphum_ai_system_assistant/core/security/risk_classifier.dart';

void main() {
  const RiskClassifier classifier = RiskClassifier();

  test('safe action is classified as safe', () {
    expect(classifier.classify('application.open'), ActionRisk.safe);
  });

  test('screen recording requires confirmation', () {
    expect(
      classifier.classify('screen_recording.start'),
      ActionRisk.confirmationRequired,
    );
  });

  test('permission bypass is restricted', () {
    expect(
      classifier.classify('permission.bypass'),
      ActionRisk.restricted,
    );
  });
}
