import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode _themeMode;
  bool notificationsEnabled;

  ThemeViewModel({
    ThemeMode initialMode = ThemeMode.system,
    this.notificationsEnabled = true,
  }) : _themeMode = initialMode;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool darkEnabled) {
    _themeMode = darkEnabled ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setNotificationsEnabled(bool enabled) {
    notificationsEnabled = enabled;
    notifyListeners();
  }
}
