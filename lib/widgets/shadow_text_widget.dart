import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ShadowTextWidget extends StatelessWidget {
  const ShadowTextWidget({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: 1.0,
            left: 1.0,
            child: Text(
              text,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Text(text, style: style),
          ),
        ],
      ),
    );
  }
}
