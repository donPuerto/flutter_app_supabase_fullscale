// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unused_field, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../pages/profile/profile_page.dart';
import '../../widgets/custom_snackbar_widget.dart';
import 'user_service.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient client;

  AuthService(this.client) {
    listenToAuthStatus();
  }

  Future<String?> signInWithOAuth(
    Provider provider,
    BuildContext context,
  ) async {
    try {
      final UserService _userService = UserService();
      final res = await client.auth.signInWithOAuth(
        provider,
        redirectTo: kIsWeb ? null : 'io.supabase.flutter://reset-callback/',
      );
      final supabase = Supabase.instance.client;
      final Session? session = supabase.auth.currentSession;
      final String? oAuthToken = session?.providerToken;

      print('session $session');
      print('oAuthToken $oAuthToken');
      // final session = await _userService.getCurrentSession();
      // final userId = session?.user.id;

      // print('userid $userId');

      // final response =
      //     await getProfileById('253e09cd-0454-41ba-a40e-43bd4985b25b');

      // print('getProfileById $response');

      // Navigator.pushNamed(
      //   context,
      //   ProfilePage.routeName,
      //   arguments: response,
      // );
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
    return null;
  }

  Future<void> signIn(
    String _email,
    String _password,
    BuildContext context,
  ) async {
    try {
      final AuthResponse res = await client.auth.signInWithPassword(
        email: _email,
        password: _password,
      );
      final Session? session = res.session;
      if (session != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const ProfilePage(),
          ),
        );
      }

      final UserService _userService = UserService();
      final userId = await _userService.getCurrentUserId();
      print('userId $userId');
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
  }

  Future<void> signUp(
    String _email,
    String _password,
    BuildContext context,
  ) async {
    try {
      await client.auth.signUp(
        email: _email,
        password: _password,
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
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  Future<void> verifyOtp({
    required String userEmail,
    required String otp,
  }) async {
    await client.auth.verifyOTP(
      token: otp,
      type: OtpType.magiclink,
      email: userEmail,
    );
  }

  StreamSubscription<AuthState> listenToAuthStatus() {
    print('StreamSubscription');
    return client.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      final AuthChangeEvent event = data.event;

      print('StreamSubscription session $session');

      switch (event) {
        case AuthChangeEvent.signedIn:
          if (session != null) {
            // navigate
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => const ProfilePage(),
            //   ),
            // );
            return;
          }
          print('listenToAuthStatus session null');
          break;
        case AuthChangeEvent.passwordRecovery:
          break;
        case AuthChangeEvent.signedOut:
          break;
        case AuthChangeEvent.tokenRefreshed:
          break;
        case AuthChangeEvent.userUpdated:
          break;
        case AuthChangeEvent.userDeleted:
          break;
        case AuthChangeEvent.mfaChallengeVerified:
          break;
      }
    });
  }
}
