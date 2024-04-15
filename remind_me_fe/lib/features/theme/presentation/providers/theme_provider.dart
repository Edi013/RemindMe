import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late String currentThemeName; //system_theme_name;
  late SharedPreferences preferences;

  ThemeProvider() {
    init();
  }

  init() {
    preferences = sl<SharedPreferences>();

    final existingValue = preferences.getString(selectedThemeSharedPreferances);
    updateTheme(existingValue ?? system_theme_name);
  }

  void updateTheme(String themeName) {
    swapTheme(themeName);
    notifyListeners();
  }

  void swapTheme(String themeName) {
    if (themeName != dark_theme_name &&
        themeName != light_theme_name &&
        themeName != system_theme_name) {
      throw AssertionError(error_message_constants_not_used_theme);
    }
    currentThemeName = themeName;
    preferences.setString(selectedThemeSharedPreferances, themeName);

    buildAppThemeMode();
  }

  ThemeMode buildAppThemeMode() {
    switch (currentThemeName) {
      case light_theme_name:
        return ThemeMode.light;
      case dark_theme_name:
        return ThemeMode.dark;
      case system_theme_name:
        return ThemeMode.system;
    }
    throw AssertionError(error_message_constants_not_used_theme);
  }
}
