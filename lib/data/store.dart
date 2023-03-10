import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> saveMap(String key, Map<String, dynamic> value) async {
    saveString(key, json.encode(value));
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = (await SharedPreferences.getInstance());
    return prefs.getString(key);
  }

  static Future<Map<String, dynamic>?> getMap(String? key) async {
    try {
      String? jsonString = await getString(key!);
      Map<String, dynamic>? map =
          jsonString != null ? json.decode(jsonString) : null;
      return map;
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
