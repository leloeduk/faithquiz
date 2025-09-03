import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final int seconds;
  final VoidCallback onTimeUp;

  const TimerWidget({super.key, required this.seconds, required this.onTimeUp});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int remaining;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.seconds;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining <= 0) {
        t.cancel();
        widget.onTimeUp();
      } else {
        setState(() => remaining--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Time: $remaining s', style: const TextStyle(fontSize: 20));
  }
}
