/*
***How to use in a function?

import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_app_name/shared_preferences_service.dart';

class MyClass {
  String _myValue = '';

  Future<void> loadMyValue() async {
    SharedPreferences prefs = await SharedPreferencesService.instance;
    _myValue = prefs.getString('my_value') ?? '';
  }

  Future<void> saveMyValue(String newValue) async {
    SharedPreferences prefs = await SharedPreferencesService.instance;
    await prefs.setString('my_value', newValue);
    _myValue = newValue;
  }

  String get myValue => _myValue;
}




***How to use in a widget?
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_app_name/shared_preferences_service.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _myValue = '';

  @override
  void initState() {
    super.initState();
    _loadMyValue();
  }

  void _loadMyValue() async {
    SharedPreferences prefs = await SharedPreferencesService.instance;
    setState(() {
      _myValue = prefs.getString('my_value') ?? '';
    });
  }

  void _saveMyValue(String newValue) async {
    SharedPreferences prefs = await SharedPreferencesService.instance;
    await prefs.setString('my_value', newValue);
    setState(() {
      _myValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('My Value: $_myValue'),
          TextField(
            onChanged: (newValue) {
              _saveMyValue(newValue);
            },
            decoration: InputDecoration(
              labelText: 'Enter a value',
            ),
          ),
        ],
      ),
    );
  }
}

*/

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _instance;

  static Future<SharedPreferences> get instance async {
    return _instance ??= await SharedPreferences.getInstance();
  }
}
