import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/core/constants.dart';

class AppTheme {
  late String currentThemeName;
  //late ThemeData currentThemeData;

  AppTheme({String currentTheme = system_theme}) {
    currentThemeName = currentTheme;
    //_buildAppTheme(context);
  }

  // void _buildAppTheme(BuildContext context) {
  //   switch (currentThemeName) {
  //     case light_theme:
  //       currentThemeData = _buildLightTheme();
  //       break;
  //     case dark_theme:
  //       currentThemeData = _buildDarkTheme();
  //       break;
  //     case system_theme:
  //       Brightness brightness = MediaQuery.of(context).platformBrightness;

  //       // ThemeMode currentThemeMode = brightness == Brightness.dark
  //       //     ? _buildDarkTheme()
  //       //     : _buildLightTheme();
  //       currentThemeData = brightness == Brightness.dark
  //           ? _buildDarkTheme()
  //           : _buildLightTheme(); //_buildLightTheme();
  //       // sa punem check ul asta cu theme mode in main
  //       break;
  //   }
  // }

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

  // ThemeData _buildLightTheme() {
  //   return lightTheme;
  // }

  // ThemeData _buildDarkTheme() {
  //   return darkTheme;
  // }

  void swapTheme(String themeName) {
    if (themeName != dark_theme &&
        themeName != light_theme &&
        themeName != system_theme) {
      throw AssertionError(error_message_constants_not_used);
    }
    currentThemeName = themeName;

    buildAppThemeMode();
  }
}
