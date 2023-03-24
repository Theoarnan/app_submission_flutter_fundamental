import 'package:shared_preferences/shared_preferences.dart';

abstract class SharePreferencesApp {
  saveFirstLaunch(bool isFirst);
  saveTheme(bool isDark);
  getheme();
  saveAlarm(bool value);
  Future<bool> getAlarmValue();
}

class SharePreferencesAppImpl implements SharePreferencesApp {
  @override
  Future<bool> getAlarmValue() {
    throw UnimplementedError();
  }

  @override
  saveAlarm(bool value) {
    throw UnimplementedError();
  }

  @override
  saveFirstLaunch(bool isFirst) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirst', isFirst);
  }

  @override
  saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('themeDark', isDark);
  }

  @override
  getheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('themeDark') ?? false;
  }
}

// class RestaurantSharePreferencesImpl extends RestaurantSharePreferences {
//   @override
//   Future<bool> getAlarmValue() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     return _prefs.getBool('alarm');
//   }

//   @override
//   saveAlarm(bool value) async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     _prefs.setBool('alarm', value);
//   }
// }