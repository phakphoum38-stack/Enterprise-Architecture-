import 'package:flutter/material.dart';

import '../../application/action_orchestrator.dart';
import '../../core/actions/action_result.dart';
import '../../core/actions/system_action.dart';
import '../../core/audit/activity_log.dart';
import '../../core/commands/command_parser.dart';
import '../../core/control/emergency_stop_controller.dart';
import '../../core/platform/mock_platform_adapter.dart';
import '../../core/security/permission_engine.dart';
import '../../core/security/risk_classifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _commandController = TextEditingController();
  final CommandParser _parser = const CommandParser(RiskClassifier());
  final EmergencyStopController _emergencyStop = EmergencyStopController();
  final ActivityLog _activityLog = ActivityLog();

  late final ActionOrchestrator _orchestrator = ActionOrchestrator(
    platformAdapter: MockPlatformAdapter(),
    permissionEngine: const PermissionEngine(),
    emergencyStopController: _emergencyStop,
  );

  String _status = 'พร้อมรับคำสั่ง';
  bool _busy = false;

  @override
  void dispose() {
    _commandController.dispose();
    _emergencyStop.dispose();
    super.dispose();
  }

  Future<void> _submitCommand() async {
    final String command = _commandController.text.trim();
    if (command.isEmpty || _busy) return;

    setState(() {
      _busy = true;
      _status = 'กำลังวิเคราะห์คำสั่ง…';
    });

    try {
      final SystemAction action = _parser.parse(command);
      bool confirmed = false;

      if (action.requiresConfirmation && action.risk != ActionRisk.restricted) {
        confirmed = await _confirmAction(action);
        if (!confirmed) {
          setState(() => _status = 'ผู้ใช้ยกเลิกคำสั่ง');
          return;
        }
      }

      final ActionResult result = await _orchestrator.execute(
        action,
        userConfirmed: confirmed,
      );
      _activityLog.record(action, result);

      if (!mounted) return;
      setState(() {
        _status = result.success
            ? result.message
            : '${result.message} (${result.errorCode ?? 'unknown_error'})';
      });
    } on FormatException catch (error) {
      setState(() => _status = error.message.toString());
    } on OperationCancelledException {
      setState(() => _status = 'คำสั่งถูกหยุดด้วย Emergency Stop');
    } catch (error) {
      setState(() => _status = 'เกิดข้อผิดพลาด: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _confirmAction(SystemAction action) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('ยืนยันการทำงาน'),
            content: Text('AI กำลังจะทำคำสั่ง: ${action.name}'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('ยกเลิก'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('อนุญาต'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _triggerEmergencyStop() {
    _emergencyStop.trigger();
    setState(() => _status = 'หยุดคำสั่งและคิวทั้งหมดแล้ว');
  }

  void _resetEmergencyStop() {
    _emergencyStop.reset();
    setState(() => _status = 'รีเซ็ต Emergency Stop แล้ว พร้อมรับคำสั่ง');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phakphum AI System Assistant')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Enterprise AI Command Center',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(_status),
              const SizedBox(height: 8),
              Text('Activity log: ${_activityLog.entries.length} รายการ'),
              const SizedBox(height: 24),
              TextField(
                controller: _commandController,
                enabled: !_busy,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'คำสั่ง AI',
                  hintText: 'เช่น เริ่มบันทึกหน้าจอพร้อมไมโครโฟน',
                ),
                onSubmitted: (_) => _submitCommand(),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _busy ? null : _submitCommand,
                icon: _busy
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.smart_toy_outlined),
                label: const Text('ส่งคำสั่ง'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _triggerEmergencyStop,
                icon: const Icon(Icons.stop_circle_outlined),
                label: const Text('หยุดฉุกเฉิน'),
              ),
              if (_emergencyStop.isStopped) ...<Widget>[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _resetEmergencyStop,
                  child: const Text('รีเซ็ตและเปิดใช้งาน AI อีกครั้ง'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
