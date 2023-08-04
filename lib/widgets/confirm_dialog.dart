import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  String title;
  String detail;

  ConfirmDialog({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(detail),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: const Text('close'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
