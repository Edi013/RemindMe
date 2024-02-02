import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/core/constants.dart';

class AppTheme {
  late String currentThemeName;
  late ThemeData currentThemeData;

  AppTheme({String currentTheme = system_theme}) {
    currentThemeName = currentTheme;
    _buildAppTheme();
  }

  void _buildAppTheme() {
    switch (currentThemeName) {
      case light_theme:
        currentThemeData = _buildLightTheme();
        break;
      case system_theme:
        currentThemeData = _buildLightTheme();
        break;
      case dark_theme:
        currentThemeData = _buildDarkTheme();
        break;
    }
  }

  ThemeData _buildLightTheme() {
    return lightTheme;
  }

  ThemeData _buildDarkTheme() {
    return darkTheme;
  }

  void swapTheme(String themeName) {
    if (themeName != dark_theme &&
        themeName != light_theme &&
        themeName != system_theme) {
      throw AssertionError(
          "Theme name doesn't use one of the allowed constants for theme name !");
    }
    currentThemeName = themeName;

    _buildAppTheme();
  }
}
