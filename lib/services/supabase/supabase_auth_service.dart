// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tuple/tuple.dart';

import '../../config/environment.dart';
import '../shared_preferences_service.dart';
import 'supabase_user_service.dart';

class SupabaseAuthService extends ChangeNotifier {
  late final SupabaseClient _supabaseClient;

  // ignore: unused_field, prefer_typing_uninitialized_variables
  var _currentUser;

  Future<void> initialize() async {
    _supabaseClient = SupabaseClient(
      Environment.supabaseUrl,
      Environment.supabaseAnonKey,
    );
    SharedPreferences _preferences = await SharedPreferencesService.instance;
    final storedSession = _preferences.getString('session');
    if (storedSession != null) {
      _supabaseClient.auth.recoverSession(storedSession);
    }

    _supabaseClient.auth.onAuthStateChange.listen((data) {
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
      final AuthResponse res = await _supabaseClient.auth.signInWithPassword(
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

  Future<Tuple2<bool, String>> signUp(String _email, String _password) async {
    try {
      final AuthResponse res = await _supabaseClient.auth.signUp(
        email: _email,
        password: _password,
      );
      final User? user = res.user;
      await SupabaseUserService().currentUser(user);
      return const Tuple2<bool, String>(true, ''); // sign-in success
    } on AuthException catch (error) {
      return Tuple2<bool, String>(false, error.message);
    } catch (error) {
      return const Tuple2<bool, String>(false, 'Unexpected error occurred');
    }
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  Future<bool> isAuthenticated() async {
    final session = _supabaseClient.auth.currentSession;
    final now = DateTime.now().toUtc();
    return session != null &&
        session.expiresAt != null &&
        DateTime.fromMillisecondsSinceEpoch(session.expiresAt!).isAfter(now);
  }

  User? getCurrentUser() {
    final session = _supabaseClient.auth.currentSession;
    return session?.user;
  }

  StreamSubscription<AuthState> onAuthStateChanges(
    void Function(AuthChangeEvent event) listener,
  ) {
    return _supabaseClient.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        listener(AuthChangeEvent.signedIn);
      } else if (event == AuthChangeEvent.signedOut) {
        listener(AuthChangeEvent.signedOut);
      }
    });
  }
}
