import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save data
  static Future<void> setData({required String key, required dynamic value}) async {
    if (_preferences == null) return;

    if (value is int) {
      await _preferences!.setInt(key, value);
    } else if (value is double) {
      await _preferences!.setDouble(key, value);
    } else if (value is bool) {
      await _preferences!.setBool(key, value);
    } else if (value is String) {
      await _preferences!.setString(key, value);
    } else if (value is List<String>) {
      await _preferences!.setStringList(key, value);
    }
  }

  // Get data
  static dynamic getData({required String key}) {
    return _preferences?.get(key);
  }

  // Remove data
  static Future<void> removeData({required String key}) async {
    if (_preferences != null) {
      await _preferences!.remove(key);
    }
  }

  // Clear all data
  static Future<void> clearData() async {
    if (_preferences != null) {
      await _preferences!.clear();
    }
  }
}
