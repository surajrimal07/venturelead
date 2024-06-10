import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Type { warn, error, success, info }

class CustomToast {
  static void showToast(
    String message, {
    Color? customBackgroundColor,
    Color? customTextColor,
    double? customFontSize,
    int? customTimeInSecForIosWeb,
    Toast? customToastLength,
    Type? customType,
  }) {
    Color backgroundColor = customBackgroundColor ?? Colors.black;
    Color textColor = customTextColor ?? Colors.white;
    double fontSize = customFontSize ?? 14.0;
    int timeInSecForIosWeb = customTimeInSecForIosWeb ?? 1;
    Toast toastLength = customToastLength ?? Toast.LENGTH_SHORT;

    switch (customType) {
      case Type.warn:
        backgroundColor = Colors.orange;
        break;
      case Type.error:
        backgroundColor = Colors.red;
        break;
      case Type.success:
        backgroundColor = Colors.green;
        break;
      case Type.info:
        backgroundColor = Colors.blue;
        break;
      default:
        backgroundColor = Colors.black;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
