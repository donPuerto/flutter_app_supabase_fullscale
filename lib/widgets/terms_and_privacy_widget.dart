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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onCheckedChanged,
            ),
            const SizedBox(
                width:
                    8), // added a SizedBox to add some space between the checkbox and text
            const Text('By signing up you accept the '),
            GestureDetector(
              onTap: onTermsPressed,
              child: const Text(
                'Terms of service',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text(' and '),
            GestureDetector(
              onTap: onPrivacyPressed,
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
