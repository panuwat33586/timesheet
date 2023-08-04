import 'package:flutter/material.dart';

class TimesheetStatus extends StatelessWidget {
  String status;

  TimesheetStatus({super.key, required this.status});

  getStatusColor(String status) {
    print(status);
    switch (status) {
      case 'w':
        return Colors.yellow.shade200;
      case 'a':
        return Colors.green.shade200;
      case 'r':
        return Colors.red.shade200;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: double.infinity,
      color: getStatusColor(status),
      child: Center(
        child: Text(
          status,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
