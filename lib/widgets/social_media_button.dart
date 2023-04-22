import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialLoginButtonType {
  googleLogin,
  facebookLogin,
  twitterLogin,
  generalLogin,
  githubLogin,
}

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
    final defaultButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
    );

    switch (buttonType) {
      case SocialLoginButtonType.googleLogin:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
          label: Text(
            text ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 14.0,
            ),
          ),
          style: defaultButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFEA4335),
            ),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(double.infinity, height ?? 50)),
          ),
        );
      case SocialLoginButtonType.facebookLogin:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: const FaIcon(
            FontAwesomeIcons.facebook,
            color: Colors.white,
          ),
          label: Text(
            text ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 14.0,
            ),
          ),
          style: defaultButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF1877F2),
            ),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(double.infinity, height ?? 50)),
          ),
        );
      case SocialLoginButtonType.twitterLogin:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.white,
          ),
          label: Text(
            text ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 14.0,
            ),
          ),
          style: defaultButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFEA4335),
            ),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(width ?? 250, height ?? 50)),
          ),
        );
      case SocialLoginButtonType.generalLogin:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 20),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            elevation: 0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FaIcon(
                    icon,
                    color: Colors.white,
                    size: imageWidth ?? 16.0,
                  ),
                ),
              if (imageURL != null || imagepath != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundImage: imageURL != null
                        ? NetworkImage(imageURL!)
                        : AssetImage(imagepath!) as ImageProvider<Object>,
                  ),
                ),
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: fontSize ?? 25.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      case SocialLoginButtonType.githubLogin:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: const FaIcon(
            FontAwesomeIcons.github,
            color: Colors.white,
          ),
          label: Text(
            text ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 14.0,
            ),
          ),
          style: defaultButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF24292E),
            ),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => Size(width ?? 250, height ?? 50)),
          ),
        );
      default:
        throw Exception('Unsupported button type');
    }
  }
}
