// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSnackbarWidget extends SnackBar {
  CustomSnackbarWidget({
    Key? key,
    required String message,
    SnackBarType type = SnackBarType.Information,
    Duration duration = const Duration(seconds: 3),
  }) : super(
          key: key,
          duration: duration,
          backgroundColor: _getBackgroundColor(type),
          content: Row(
            children: [
              Icon(_getIconData(type)),
              const SizedBox(width: 8),
              Text(message),
            ],
          ),
        );

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.Error:
        return Colors.red;
      case SnackBarType.Success:
        return Colors.green;
      case SnackBarType.Information:
      default:
        return Colors.blue;
    }
  }

  static IconData _getIconData(SnackBarType type) {
    switch (type) {
      case SnackBarType.Error:
        return FontAwesomeIcons.circleExclamation;
      case SnackBarType.Success:
        return FontAwesomeIcons.circleCheck;
      case SnackBarType.Information:
      default:
        return FontAwesomeIcons.circleInfo;
    }
  }
}

enum SnackBarType {
  Error,
  Success,
  Information,
}
