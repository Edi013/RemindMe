import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';

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
    throw AssertionError(error_message_constants_not_used);
  }

  void swapTheme(String themeName) {
    if (themeName != dark_theme &&
        themeName != light_theme &&
        themeName != system_theme) {
      throw AssertionError(error_message_constants_not_used);
    }
    currentThemeName = themeName;

    buildAppThemeMode();
  }

  Color getAccentColor() {
    switch (currentThemeName) {
      case light_theme:
        return lightAccent;
      case dark_theme:
        return darkAccent;
      case system_theme:
        break;
    }
    throw AssertionError(error_message_constants_not_used);
  }
}
