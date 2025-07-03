import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const THEME_MODE = 'Mode';
  static const DARK = 'Dark';
  static const LIGHT = 'Light';

  setModeTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_MODE, theme);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(THEME_MODE) ?? LIGHT;
  }
}