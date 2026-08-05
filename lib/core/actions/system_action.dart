enum ActionRisk { safe, confirmationRequired, restricted }

class SystemAction {
  const SystemAction({
    required this.id,
    required this.name,
    required this.parameters,
    required this.risk,
  });

  final String id;
  final String name;
  final Map<String, Object?> parameters;
  final ActionRisk risk;

  bool get requiresConfirmation =>
      risk == ActionRisk.confirmationRequired ||
      risk == ActionRisk.restricted;
}
