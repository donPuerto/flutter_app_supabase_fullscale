import 'package:flutter/material.dart';

class SizedBoxWidget extends StatelessWidget {
  final double height;

  const SizedBoxWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
