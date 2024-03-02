import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';

class AppTheme {
  late String currentThemeName;

  AppTheme({String currentTheme = system_theme_name}) {
    currentThemeName = currentTheme;
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

  void swapTheme(String themeName) {
    if (themeName != dark_theme_name &&
        themeName != light_theme_name &&
        themeName != system_theme_name) {
      throw AssertionError(error_message_constants_not_used_theme);
    }
    currentThemeName = themeName;

    buildAppThemeMode();
  }
}
