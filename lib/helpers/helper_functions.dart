import 'package:flutter/material.dart';

void showResult({
  required BuildContext context,
  required String title,
  required String body,
  required VoidCallback onPlayAgain,
  required VoidCallback onCancel,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Quit')),

        TextButton(onPressed: onCancel, child: const Text('Play again')),
      ],
    ),
  );
}

void showMessage(BuildContext context, String mgs) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text('Not a word in my dictionary')));
