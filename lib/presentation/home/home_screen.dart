import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _commandController = TextEditingController();
  String _status = 'พร้อมรับคำสั่ง';

  @override
  void dispose() {
    _commandController.dispose();
    super.dispose();
  }

  void _submitCommand() {
    final String command = _commandController.text.trim();
    if (command.isEmpty) {
      return;
    }
    setState(() {
      _status = 'รับคำสั่งแล้ว: $command';
    });
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
              const SizedBox(height: 24),
              TextField(
                controller: _commandController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'คำสั่ง AI',
                  hintText: 'เช่น เริ่มบันทึกหน้าจอพร้อมไมโครโฟน',
                ),
                onSubmitted: (_) => _submitCommand(),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _submitCommand,
                icon: const Icon(Icons.smart_toy_outlined),
                label: const Text('ส่งคำสั่ง'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _status = 'หยุดคำสั่งและคิวทั้งหมดแล้ว';
                  });
                },
                icon: const Icon(Icons.stop_circle_outlined),
                label: const Text('หยุดฉุกเฉิน'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
