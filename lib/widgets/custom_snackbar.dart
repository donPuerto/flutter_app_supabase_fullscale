// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class CustomSnackbar extends StatefulWidget {
  final String message;
  final SnackBarType type;

  const CustomSnackbar({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  State<CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    IconData iconData;

    switch (widget.type) {
      case SnackBarType.Error:
        backgroundColor = Colors.red;
        iconData = Icons.error;
        break;
      case SnackBarType.Success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle_outline;
        break;
      case SnackBarType.Information:
        backgroundColor = Colors.blue;
        iconData = Icons.info_outline;
        break;
      default:
        backgroundColor = Colors.grey;
        iconData = Icons.info_outline;
    }

    return ScaffoldMessenger(
      child: SnackBar(
        content: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 8),
            Text(widget.message),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

enum SnackBarType {
  Error,
  Success,
  Information,
}
