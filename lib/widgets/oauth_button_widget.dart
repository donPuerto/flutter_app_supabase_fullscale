// ignore_for_file: use_build_context_synchronously

/*

  How to call this widget?
  OAuthButtonWidget(
    provider: Provider.google,
    page: const ProfilePage(),
  ),
 */

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/supabase/auth_service.dart';
import '../utils/types.dart';
import 'custom_snackbar_widget.dart';
import 'social_media_button.dart';

class OAuthButtonWidget extends StatelessWidget {
  final Provider provider;
  final Widget page;

  const OAuthButtonWidget({
    super.key,
    required this.provider,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return SocialMediaButton(
      buttonType: _getButtonType(),
      onPressed: () async {
        try {
          await AuthService().signInWithOAuth(
            provider,
            context,
          );

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => page,
            ),
          );
        } on AuthException catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackbarWidget(
              message: error.message,
              type: SnackBarType.Error,
            ),
          );
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackbarWidget(
              message: 'Unexpected error occurred',
              type: SnackBarType.Error,
            ),
          );
        }
      },
    );
  }

  SocialLoginButtonType _getButtonType() {
    switch (provider) {
      case Provider.google:
        return SocialLoginButtonType.googleLogin;
      case Provider.facebook:
        return SocialLoginButtonType.facebookLogin;
      case Provider.twitter:
        return SocialLoginButtonType.twitterLogin;
      case Provider.github:
        return SocialLoginButtonType.githubLogin;
      default:
        throw UnsupportedError('Provider not supported: $provider');
    }
  }
}
