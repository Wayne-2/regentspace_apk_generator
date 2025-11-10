import 'package:flutter/material.dart';

Future<void> showAlertBox(
  BuildContext context,
  String title,
  String message, {
  bool isError = false,
}) async {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: isError ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
