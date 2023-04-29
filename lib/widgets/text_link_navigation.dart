/*
  How to call TextLinkButton?
  TextLinkNavigation(
    page: SignInPage(),
    text1: 'Already have an account? ',
    text2: 'Sign In',
    alignment: Alignment.centerRight,
  )

  Container(
            margin:
                const EdgeInsets.fromLTRB(10, 20, 10, 20),
            //child: Text('Don\'t have an account? Create'),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: "Already have an account? "),
                  TextSpan(
                    text: 'Sign In',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignInPage()));
                      },
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary),
                  ),
                ],
              ),
            ),
          ),
*/

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextLinkNavigation extends StatelessWidget {
  final Widget page;
  final String text1;
  final String text2;
  final Alignment alignment;

  const TextLinkNavigation({
    Key? key,
    required this.page,
    required this.text1,
    required this.text2,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: text1),
            TextSpan(
              text: text2,
              recognizer: TapGestureRecognizer()..onTap = () => _onTap(context),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
