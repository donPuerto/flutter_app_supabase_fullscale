import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/types.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final ButtonType buttonType;

  const SocialMediaButton({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
    required this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.elevatedButton:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: FaIcon(
            icon,
            color: Colors.white,
          ),
        );
      case ButtonType.outlinedButton:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: backgroundColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: FaIcon(
              icon,
              color: backgroundColor,
            ),
          ),
        );

      case ButtonType.textButton:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: backgroundColor,
          ),
          child: FaIcon(
            icon,
            color: backgroundColor,
          ),
        );
      case ButtonType.iconButton:
        return IconButton(
          onPressed: onPressed,
          icon: FaIcon(
            icon,
            color: backgroundColor,
          ),
        );
      case ButtonType.floatingActionButton:
        return FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          child: FaIcon(
            icon,
            color: Colors.white,
          ),
        );
      default:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: FaIcon(
            icon,
            color: Colors.white,
          ),
        );
    }
  }
}
