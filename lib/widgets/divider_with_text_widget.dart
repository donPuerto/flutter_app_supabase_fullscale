import 'package:flutter/material.dart';

/*
  How to call DividerWithTextWidget class?
  const DividerWithTextWidget(text: 'OR');
*/

class DividerWithTextWidget extends StatelessWidget {
  final String text;
  final Color color;

  const DividerWithTextWidget({
    Key? key,
    required this.text,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: color,
          ),
        ),
      ],
    );
  }
}
