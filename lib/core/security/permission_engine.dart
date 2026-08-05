import '../actions/system_action.dart';

class PermissionDecision {
  const PermissionDecision({
    required this.allowed,
    required this.requiresConfirmation,
    required this.reason,
  });

  final bool allowed;
  final bool requiresConfirmation;
  final String reason;
}

/// Central policy gate used before any platform adapter executes an action.
class PermissionEngine {
  const PermissionEngine();

  PermissionDecision evaluate(SystemAction action) {
    return switch (action.risk) {
      ActionRisk.safe => const PermissionDecision(
          allowed: true,
          requiresConfirmation: false,
          reason: 'Safe action.',
        ),
      ActionRisk.confirmationRequired => const PermissionDecision(
          allowed: true,
          requiresConfirmation: true,
          reason: 'User confirmation is required.',
        ),
      ActionRisk.restricted => const PermissionDecision(
          allowed: false,
          requiresConfirmation: true,
          reason: 'Restricted action is blocked by enterprise policy.',
        ),
    };
  }
}
