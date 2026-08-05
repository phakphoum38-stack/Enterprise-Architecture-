import '../actions/action_result.dart';
import '../actions/system_action.dart';

class ActivityLogEntry {
  const ActivityLogEntry({
    required this.timestamp,
    required this.action,
    required this.result,
  });

  final DateTime timestamp;
  final SystemAction action;
  final ActionResult result;
}

class ActivityLog {
  final List<ActivityLogEntry> _entries = <ActivityLogEntry>[];

  List<ActivityLogEntry> get entries => List<ActivityLogEntry>.unmodifiable(_entries);

  void record(SystemAction action, ActionResult result) {
    _entries.add(
      ActivityLogEntry(
        timestamp: DateTime.now().toUtc(),
        action: action,
        result: result,
      ),
    );
  }

  void clear() => _entries.clear();
}
