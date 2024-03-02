import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';

class AppTheme {
  late String currentThemeName;

  AppTheme({String currentTheme = system_theme}) {
    currentThemeName = currentTheme;
  }

  ThemeMode buildAppThemeMode() {
    switch (currentThemeName) {
      case light_theme:
        return ThemeMode.light;
      case dark_theme:
        return ThemeMode.dark;
      case system_theme:
        return ThemeMode.system;
    }
    throw AssertionError(error_message_constants_not_used_theme);
  }

  void swapTheme(String themeName) {
    if (themeName != dark_theme &&
        themeName != light_theme &&
        themeName != system_theme) {
      throw AssertionError(error_message_constants_not_used_theme);
    }
    currentThemeName = themeName;

    buildAppThemeMode();
  }
}
