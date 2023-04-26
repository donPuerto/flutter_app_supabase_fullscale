// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_supabase_fullscale/services/supabase/client_service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widgets/custom_snackbar_widget.dart';

class AuthService extends ChangeNotifier {
  Stream<AuthChangeEvent>? _authStateChanges;
  bool _isAuthenticated = false;

  authService(supabaseClient) {
    // Subscribe to Supabase auth state changes
    _authStateChanges = supabaseClient.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent? event = data.event;
      _isAuthenticated = event != null;
    });
  }

  bool get isAuthenticated => _isAuthenticated;

  Future<String?> signInWithOAuth(
    Provider provider,
    BuildContext context,
  ) async {
    try {
      await supabaseClient.auth.signInWithOAuth(provider);
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
      await supabaseClient.auth.signInWithPassword(
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

  Future<void> signUp(
    String _email,
    String _password,
    BuildContext context,
  ) async {
    try {
      await supabaseClient.auth.signUp(
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
    await supabaseClient.auth.signOut();
  }
}
