import 'package:flutter/material.dart';

enum DialogBoxType { success, info, warn, danger }

class ShowDialogBox {
  final String title;
  final String content;
  final String firstValue;
  final String secondValue;
  final VoidCallback onPressed;
  final DialogBoxType type;

  const ShowDialogBox({
    required this.firstValue,
    required this.secondValue,
    required this.onPressed,
    required this.type,
    required this.title,
    required this.content,
  });

  Color? get backgroundColor {
    switch (type) {
      case DialogBoxType.success:
        return Colors.green[600];
      case DialogBoxType.info:
        return Colors.blue[600];
      case DialogBoxType.warn:
        return Colors.orange[600];
      case DialogBoxType.danger:
        return Colors.red[600];
      default:
        return Colors.blue[600];
    }
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text(firstValue),
            ),
          ],
        );
      },
    );
  }
}
