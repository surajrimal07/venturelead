import 'package:flutter/material.dart';

enum SnackBarType { success, info, warn, danger }

void showSnackBar(BuildContext context, String text, SnackBarType type) {
  Color? backgroundColor;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = Colors.green[600]; // Success green
      break;
    case SnackBarType.info:
      backgroundColor = Colors.blue[600]; // Info blue
      break;
    case SnackBarType.warn:
      backgroundColor = Colors.orange[600]; // Warn orange
      break;
    case SnackBarType.danger:
      backgroundColor = Colors.red[600]; // Danger red
      break;
    default:
      backgroundColor = Colors.blue[600]; // Info blue
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
    ),
  );
}
