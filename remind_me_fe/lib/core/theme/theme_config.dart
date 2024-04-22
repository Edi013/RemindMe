import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';

const Color primary = Color.fromARGB(255, 85, 162, 175);
const Color accent = Color(0xFF468c98);
const Color bg = Color.fromARGB(255, 85, 162, 175);

const Color lightPrimary = primary; //Color.fromARGB(255, 225, 225, 225);
const Color lightAccent = accent;
const Color lightBG = white; //Color.fromARGB(255, 192, 192, 192);

const Color darkPrimary = smokeAccent;
const Color darkAccent = smokeWhite;
const Color darkBG = grey;

const Color red = Color.fromARGB(0, 39, 39, 39);
const Color black = Color.fromARGB(255, 15, 15, 15);
const Color white = Color(0xFFFFFFFF);
const Color halfSmokeWhite = Color.fromARGB(255, 228, 228, 228);
const Color smokeWhite = Color.fromARGB(255, 195, 195, 195);
const Color smokeAccent = Color.fromARGB(255, 67, 101, 107);
const Color whitenedAccent = Color.fromARGB(255, 40, 146, 164);
const Color grey = Color(0xFF2E2E2E);

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: lightPrimary,
    onBackground: lightBG,
    secondary: lightAccent,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  primaryTextTheme: const TextTheme(
    displayLarge:
        TextStyle(fontSize: kBodyLargeFontSize, color: halfSmokeWhite),
    displayMedium:
        TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    displaySmall:
        TextStyle(fontSize: kBodySmallFontSize, color: halfSmokeWhite),
    bodyLarge: TextStyle(fontSize: kBodyLargeFontSize, color: halfSmokeWhite),
    bodyMedium: TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    bodySmall: TextStyle(fontSize: kBodySmallFontSize, color: halfSmokeWhite),
    headlineLarge: TextStyle(
        fontSize: kHeadingLargeFontSize,
        fontWeight: FontWeight.bold,
        color: halfSmokeWhite),
    headlineMedium: TextStyle(
        fontSize: kHeadingMediumFontSize,
        fontWeight: FontWeight.bold,
        color: halfSmokeWhite),
    headlineSmall: TextStyle(
        fontSize: kHeadingSmallFontSize,
        fontWeight: FontWeight.bold,
        color: halfSmokeWhite),
    labelLarge: TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    labelMedium:
        TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    labelSmall: TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    titleLarge: TextStyle(fontSize: kBodyLargeFontSize, color: halfSmokeWhite),
    titleMedium:
        TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    titleSmall: TextStyle(fontSize: kBodySmallFontSize, color: halfSmokeWhite),
  ),
  splashColor: lightAccent,
  primaryColor: lightPrimary,
  scaffoldBackgroundColor: smokeAccent,
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: darkBG,
  ),
  datePickerTheme: DatePickerThemeData(
      backgroundColor: darkAccent,
      headerBackgroundColor: darkBG.withOpacity(0.5)),
  textTheme: const TextTheme(
    displayLarge:
        TextStyle(fontSize: kBodyLargeFontSize, color: halfSmokeWhite),
    displayMedium:
        TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    displaySmall:
        TextStyle(fontSize: kBodySmallFontSize, color: halfSmokeWhite),
    bodyLarge: TextStyle(fontSize: kBodyLargeFontSize, color: halfSmokeWhite),
    bodyMedium: TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    bodySmall: TextStyle(fontSize: kBodySmallFontSize, color: halfSmokeWhite),
    headlineLarge: TextStyle(
        fontSize: kHeadingLargeFontSize,
        fontWeight: FontWeight.bold,
        color: halfSmokeWhite),
    headlineMedium: TextStyle(
        fontSize: kHeadingMediumFontSize,
        fontWeight: FontWeight.bold,
        color: halfSmokeWhite),
    headlineSmall: TextStyle(
        fontSize: kHeadingSmallFontSize,
        fontWeight: FontWeight.bold,
        color: halfSmokeWhite),
    labelLarge: TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    labelMedium:
        TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    labelSmall: TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    titleLarge: TextStyle(fontSize: kBodyLargeFontSize, color: halfSmokeWhite),
    titleMedium:
        TextStyle(fontSize: kBodyMediumFontSize, color: halfSmokeWhite),
    titleSmall: TextStyle(fontSize: kBodySmallFontSize, color: halfSmokeWhite),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (lightPrimary.withOpacity(0.7)),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (lightPrimary.withOpacity(0.7)),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: darkBG.withOpacity(0.5),
    margin: const EdgeInsets.all(15),
    shadowColor: white,
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all<Color>(
      (white),
    ),
    fillColor: MaterialStateProperty.all<Color>(
      (primary),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: white,
        width: 2.0,
      ),
    ),
  ),
  snackBarTheme:
      SnackBarThemeData(backgroundColor: lightPrimary.withOpacity(0.6)),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: darkPrimary,
    onBackground: darkBG,
    secondary: smokeAccent,
    brightness: Brightness.dark,
  ),
  useMaterial3: false,
  splashColor: darkAccent,
  primaryColor: darkPrimary,
  scaffoldBackgroundColor: smokeAccent,
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: darkBG,
  ),
  datePickerTheme: DatePickerThemeData(
      backgroundColor: darkAccent,
      headerBackgroundColor: darkBG.withOpacity(0.5)),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: kBodyLargeFontSize, color: smokeWhite),
    displayMedium: TextStyle(fontSize: kBodyMediumFontSize, color: smokeWhite),
    displaySmall: TextStyle(fontSize: kBodySmallFontSize, color: smokeWhite),
    bodyLarge: TextStyle(fontSize: kBodyLargeFontSize, color: smokeWhite),
    bodyMedium: TextStyle(fontSize: kBodyMediumFontSize, color: smokeWhite),
    bodySmall: TextStyle(fontSize: kBodySmallFontSize, color: smokeWhite),
    headlineLarge: TextStyle(
        fontSize: kHeadingLargeFontSize,
        fontWeight: FontWeight.bold,
        color: smokeWhite),
    headlineMedium: TextStyle(
        fontSize: kHeadingMediumFontSize,
        fontWeight: FontWeight.bold,
        color: smokeWhite),
    headlineSmall: TextStyle(
        fontSize: kHeadingSmallFontSize,
        fontWeight: FontWeight.bold,
        color: smokeWhite),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (lightPrimary.withOpacity(0.7)),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (lightPrimary.withOpacity(0.7)),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: darkBG.withOpacity(0.3),
    margin: const EdgeInsets.all(15),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all<Color>(
      (white),
    ),
    fillColor: MaterialStateProperty.all<Color>(
      (primary),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: white,
        width: 2.0,
      ),
    ),
  ),
  snackBarTheme:
      SnackBarThemeData(backgroundColor: lightPrimary.withOpacity(0.6)),
);
