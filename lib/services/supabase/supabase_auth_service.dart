// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../shared_preferences_service.dart';
import 'supabase_client_service.dart';
import 'supabase_user_service.dart';

class SupabaseAuthService extends ChangeNotifier {
  //late final SupabaseClient _supabaseClient;

  // ignore: unused_field, prefer_typing_uninitialized_variables
  var _currentUser;

  Future<void> initialize() async {
    print('Supabase Initialize');

    // await Supabase.initialize(
    //   url: Environment.supabaseUrl,
    //   anonKey: Environment.supabaseAnonKey,
    // );

    // _supabaseClient = await Supabase.initialize(
    //   Environment.supabaseUrl,
    //   Environment.supabaseAnonKey,
    // );
    SharedPreferences _preferences = await SharedPreferencesService.instance;
    final storedSession = _preferences.getString('session');
    if (storedSession != null) {
      supabaseClient.auth.recoverSession(storedSession);
    }

    supabaseClient.auth.onAuthStateChange.listen((data) {
      if (data.session == null) {
        _currentUser = null;
        _preferences.remove('session');
      } else {
        _currentUser = data.session?.user;
        final sessionJson = data.session?.toJson();
        _preferences.setString('session', sessionJson as String);
      }
      notifyListeners();
    });
  }

  Future<void> signIn(String _email, String _password) async {
    try {
      final AuthResponse res = await supabaseClient.auth.signInWithPassword(
        email: _email,
        password: _password,
      );
      final User? user = res.user;
      await SupabaseUserService().currentUser(user);
    } on AuthException catch (error) {
      print(error.message);
    } catch (error) {
      print('Unexpected error occurred');
    }
  }

  Future<String> signUp(String _email, String _password) async {
    print(supabaseClient);
    print('signUp $_email $_password');
    try {
      final AuthResponse res = await supabaseClient.auth.signUp(
        email: _email,
        password: _password,
      );
      print('AuthResponse');
      final User? user = res.user;
      await SupabaseUserService().currentUser(user);
      // final Session? session = res.session;
      // final User? user = res.user;
      return 'Sign-up successful'; // sign-in success
    } on AuthException catch (error) {
      print('AuthException');
      return error.message;
    } catch (error) {
      print('Unexpected error occurred');
      return 'Unexpected error occurred';
    }
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  Future<bool> isAuthenticated() async {
    final session = supabaseClient.auth.currentSession;
    final now = DateTime.now().toUtc();
    return session != null &&
        session.expiresAt != null &&
        DateTime.fromMillisecondsSinceEpoch(session.expiresAt!).isAfter(now);
  }

  User? getCurrentUser() {
    final session = supabaseClient.auth.currentSession;
    return session?.user;
  }

  StreamSubscription<AuthState> onAuthStateChanges(
    void Function(AuthChangeEvent event) listener,
  ) {
    return supabaseClient.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        listener(AuthChangeEvent.signedIn);
      } else if (event == AuthChangeEvent.signedOut) {
        listener(AuthChangeEvent.signedOut);
      }
    });
  }
}
