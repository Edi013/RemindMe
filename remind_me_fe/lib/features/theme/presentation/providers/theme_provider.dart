import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';

class ThemeProvider extends ChangeNotifier {
  late String currentThemeName = dark_theme_name; //system_theme_name;
  //late String currentThemeName = light_theme_name;

  ThemeProvider();

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
