import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Duration duration;

  const CustomSnackbar({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: backgroundColor,
      duration: duration,
      content: Text(message),
    );
  }
}
