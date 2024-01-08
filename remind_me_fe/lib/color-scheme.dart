import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme getAppColorScheme() {
    int primaryColor = 0xFFB9A7C0;
    int backgroundColor = 0xFFACABAC;
    // Color(0xFFB9A7C0);
    // Color(0xFFACABAC);

    return ColorScheme.fromSwatch(
      primarySwatch: MaterialColor(
        primaryColor,
        <int, Color>{
          50: Color(primaryColor),
          100: Color(primaryColor),
          200: Color(primaryColor),
          300: Color(primaryColor),
          400: Color(primaryColor),
          500: Color(primaryColor),
          600: Color(primaryColor),
          700: Color(primaryColor),
          800: Color(primaryColor),
          900: Color(primaryColor),
        },
      ),
    ).copyWith(
      background: MaterialColor(
        backgroundColor,
        <int, Color>{
          50: Color(backgroundColor),
          100: Color(backgroundColor),
          200: Color(backgroundColor),
          300: Color(backgroundColor),
          400: Color(backgroundColor),
          500: Color(backgroundColor),
          600: Color(backgroundColor),
          700: Color(backgroundColor),
          800: Color(backgroundColor),
          900: Color(backgroundColor),
        },
      ),
    );
  }
}
