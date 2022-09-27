import 'package:flutter/material.dart';
import 'package:quizu/pages/components/button.dart';

class QAlert extends StatelessWidget {
  const QAlert({super.key, required this.onPressed, required this.message});

  final VoidCallback onPressed;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        message ?? '',
        textAlign: TextAlign.center,
      ),
      actions: [
        QButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'No',
          enabled: true,
        ),
        const SizedBox(
          height: 8,
        ),
        QButton(
          onPressed: onPressed,
          text: 'Yes',
          enabled: true,
        )
      ],
    );
  }
}
