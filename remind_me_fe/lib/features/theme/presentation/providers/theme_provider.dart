import 'package:flutter/material.dart';
import 'package:remind_me_fe/features/theme/data/local/current_app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  late AppTheme appTheme;

  ThemeProvider(AppTheme theme) {
    appTheme = theme;
  }

  void updateTheme(String themeName) {
    appTheme.swapTheme(themeName);
    notifyListeners();
  }

  ThemeMode buildThemeMode() {
    return appTheme.buildAppThemeMode();
  }
}
