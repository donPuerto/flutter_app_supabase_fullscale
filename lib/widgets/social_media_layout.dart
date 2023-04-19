import 'package:flutter/material.dart';

class SocialMediaLayout extends StatelessWidget {
  final List<Widget> children;
  final Axis layoutOrientation;
  final double padding;

  const SocialMediaLayout({
    Key? key,
    required this.children,
    this.layoutOrientation = Axis.horizontal,
    this.padding = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: layoutOrientation,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children.map((child) {
        return Padding(
          padding: layoutOrientation == Axis.horizontal
              ? EdgeInsets.symmetric(horizontal: padding)
              : EdgeInsets.symmetric(vertical: padding),
          child: child,
        );
      }).toList(),
    );
  }
}
