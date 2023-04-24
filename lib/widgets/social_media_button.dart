import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/types.dart';

/*
How to call SocialMediaButton class?
SocialMediaButton(
  buttonType: SocialLoginButtonType.googleLogin,
  onPressed: () {
    // perform action when button is pressed
  },
);

*/

class SocialMediaButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final String? imageURL;
  final String? imagepath;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? borderRadius;
  final double? imageWidth;
  final Color? backgroundColor;
  final SocialLoginButtonType? buttonType;
  final VoidCallback? onPressed;

  const SocialMediaButton({
    Key? key,
    this.icon,
    this.text,
    this.imageURL,
    this.imagepath,
    this.height,
    this.width,
    this.fontSize,
    this.borderRadius,
    this.imageWidth,
    this.backgroundColor,
    this.buttonType,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case SocialLoginButtonType.googleLogin:
        return Container(
          width: width ?? 42.0,
          height: height ?? 42.0,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.red,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            elevation: 1.0,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              onPressed: onPressed,
              tooltip: 'Sign in with Google',
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
                size: 24.0,
              ),
              splashColor: Colors.blueAccent,
              highlightColor: Colors.transparent,
              iconSize: 24.0,
            ),
          ),
        );

      case SocialLoginButtonType.facebookLogin:
        return Container(
          width: width ?? 42.0,
          height: height ?? 42.0,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            elevation: 1.0,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              onPressed: onPressed,
              tooltip: 'Sign in with Facebook',
              icon: const FaIcon(
                FontAwesomeIcons.facebookF,
                color: Colors.white,
                size: 24.0,
              ),
              splashColor: Colors.blueAccent,
              highlightColor: Colors.transparent,
              iconSize: 24.0,
            ),
          ),
        );

      case SocialLoginButtonType.twitterLogin:
        return Container(
          width: width ?? 42.0,
          height: height ?? 42.0,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            elevation: 1.0,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              onPressed: onPressed,
              tooltip: 'Sign in with Twitter',
              icon: const FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
                size: 24.0,
              ),
              splashColor: Colors.blueAccent,
              highlightColor: Colors.transparent,
              iconSize: 24.0,
            ),
          ),
        );

      case SocialLoginButtonType.githubLogin:
        return Container(
          width: width ?? 42.0,
          height: height ?? 42.0,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.black,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            elevation: 1.0,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              onPressed: onPressed,
              tooltip: 'Sign in with GitHub',
              icon: const FaIcon(
                FontAwesomeIcons.github,
                color: Colors.white,
                size: 24.0,
              ),
              splashColor: Colors.grey,
              highlightColor: Colors.transparent,
              iconSize: 24.0,
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
