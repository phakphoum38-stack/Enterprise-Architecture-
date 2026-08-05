class ActionResult {
  const ActionResult({
    required this.commandId,
    required this.success,
    required this.message,
    this.errorCode,
    this.details = const <String, Object?>{},
  });

  final String commandId;
  final bool success;
  final String message;
  final String? errorCode;
  final Map<String, Object?> details;
}
