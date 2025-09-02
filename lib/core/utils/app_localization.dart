import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocal {
  final Map<String, String> _localizedStrings;

  AppLocal(this._localizedStrings);

  static Future<AppLocal> load(String locale) async {
    String jsonString = await rootBundle.loadString(
      'assets/langs/$locale.json',
    );
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, String> strings = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return AppLocal(strings);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
