import 'package:flutter/material.dart';

enum ButtonSize { large, medium, small }

class MainElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonSize size;

  const MainElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final minimumSize = _getSizeBasedOnEnum(size);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: minimumSize,
      ),
      child: Text(text, style: const TextStyle(color: Colors.red)),
    );
  }

  Size _getSizeBasedOnEnum(ButtonSize size) {
    switch (size) {
      case ButtonSize.large:
        return const Size(200, 50);
      case ButtonSize.medium:
        return const Size(150, 40);
      case ButtonSize.small:
        return const Size(90, 40);
    }
  }
}
