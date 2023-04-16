import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final Future<SharedPreferences> _prefs;

  SharedPreferencesProvider(this._prefs);

  Future<bool> setBool(String key, bool value) async {
    final prefs = await _prefs;
    return prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await _prefs;
    return prefs.getBool(key);
  }

  Future<bool> setString(String key, String value) async {
    final prefs = await _prefs;
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await _prefs;
    return prefs.remove(key);
  }
}
