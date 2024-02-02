import 'package:flutter/foundation.dart';
import 'package:remind_me_fe/core/theme/current_app_theme.dart';
import 'package:remind_me_fe/injection_container.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider();

  void updateTheme(String themeName) {
    sl<AppTheme>().swapTheme(themeName);
    notifyListeners();
  }
}
