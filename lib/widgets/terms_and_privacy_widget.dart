import 'package:flutter/material.dart';

class TermsAndPrivacyWidget extends StatelessWidget {
  const TermsAndPrivacyWidget({
    Key? key,
    required this.onTermsPressed,
    required this.onPrivacyPressed,
    required this.isChecked,
    required this.onCheckedChanged,
  }) : super(key: key);

  final VoidCallback onTermsPressed;
  final VoidCallback onPrivacyPressed;
  final bool isChecked;
  final ValueChanged<bool?> onCheckedChanged;

  static const TextStyle _textStyle = TextStyle(
    height: 1.9,
  );

  static final TextStyle _linkTextStyle = const TextStyle(
    decoration: TextDecoration.underline,
    color: Colors.blue,
  ).merge(_textStyle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onCheckedChanged,
            ),
            const SizedBox(
              width: 8,
            ), // added a SizedBox to add some space between the checkbox and text
            const Text(
              'By signing up you accept the ',
              style: _textStyle,
            ),
            GestureDetector(
              onTap: onTermsPressed,
              child: Text(
                'Terms of service',
                style: _linkTextStyle,
              ),
            ),
            const Text(
              ' and ',
              style: _textStyle,
            ),
            GestureDetector(
              onTap: onPrivacyPressed,
              child: Text(
                'Privacy Policy',
                style: _linkTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
