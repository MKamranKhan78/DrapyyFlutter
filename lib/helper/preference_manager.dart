import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

EventBus eventBus = EventBus();

class PreferenceManager {
  static const String _prefsName = 'my_app_prefs';

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  // New function to clear all preferences data
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
 }