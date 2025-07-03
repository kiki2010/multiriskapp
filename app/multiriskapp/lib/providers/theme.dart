import 'package:flutter/material.dart';
import 'package:multiriskapp/models/theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreferences themePreferences = ThemePreferences();
  String _theme = ThemePreferences.LIGHT;

  String get theme => _theme;

  set setTheme(String theme) {
    _theme = theme;
    themePreferences.setModeTheme(theme);
    notifyListeners();
  }
}