import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesApp {
  static SharePreferencesApp? _sharePreferencesAppImpl;
  static SharedPreferences? _preferences;

  static Future<SharePreferencesApp> getInstance() async {
    if (_sharePreferencesAppImpl == null) {
      var secureStorage = SharePreferencesApp._();
      await secureStorage._init();
      _sharePreferencesAppImpl = secureStorage;
    }
    return _sharePreferencesAppImpl!;
  }

  SharePreferencesApp._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool getAlarmValue() {
    bool data = _preferences?.getBool('alarm_notification') ?? false;
    return data;
  }

  static void saveAlarm(bool value) {
    _preferences?.setBool('alarm_notification', value);
  }

  static void saveTheme(bool isDark) {
    _preferences?.setBool('theme_dark', isDark);
  }

  static bool getThemeMode() {
    bool data = _preferences?.getBool('theme_dark') ?? false;
    return data;
  }

  static void removeDataPreference() {
    _preferences?.remove('alarm_notification');
    _preferences?.remove('theme_dark');
  }
}
