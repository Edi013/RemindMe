import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';

const Color defaultPrimary = smokeAccent;
const Color defaultAccent = smokeWhite;
const Color defaultBG = grey;

const Color lightPrimary = Color.fromARGB(255, 225, 225, 225);
const Color lightBG = Color.fromARGB(255, 192, 192, 192);

const Color darkPrimary = Color.fromARGB(255, 73, 73, 73);
const Color darkAccent = smokeAccent;
const Color darkBG = Color.fromARGB(255, 53, 53, 53);

const Color black = Color.fromARGB(255, 15, 15, 15);
const Color white = Color(0xFFFFFFFF);
const Color halfSmokeWhite = Color.fromARGB(255, 228, 228, 228);
const Color smokeWhite = Color.fromARGB(255, 195, 195, 195);
const Color smokeAccent = Color.fromARGB(255, 67, 101, 107);
const Color whitenedAccent = Color.fromARGB(255, 40, 146, 164);
const Color grey = Color(0xFF2E2E2E);
const Color darkenRed = Color.fromARGB(0, 39, 39, 39);

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: defaultPrimary,
    onBackground: defaultBG,
    secondary: defaultPrimary,
    brightness: Brightness.dark,
  ),
  useMaterial3: false,
  splashColor: defaultAccent,
  primaryColor: defaultPrimary,
  scaffoldBackgroundColor: defaultPrimary,
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: darkBG,
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: white,
    headerBackgroundColor: darkBG.withOpacity(0.5),
  ),
  timePickerTheme: const TimePickerThemeData(
    backgroundColor: white,
  ),
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
        (lightPrimary.withOpacity(0.4)),
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
      (defaultPrimary),
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
    secondary: darkAccent,
    brightness: Brightness.dark,
  ),
  useMaterial3: false,
  splashColor: darkAccent,
  primaryColor: darkPrimary,
  scaffoldBackgroundColor: darkBG,
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: darkBG,
  ),
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
  datePickerTheme: DatePickerThemeData(
    backgroundColor: darkAccent,
    headerBackgroundColor: darkBG.withOpacity(0.3),
  ),
  // tabBarTheme: const TabBarTheme(
  //   labelColor: Colors.white,
  //   indicator: UnderlineTabIndicator(
  //     borderSide: BorderSide(
  //       color: lightAccent,
  //       width: 2.0,
  //     ),
  //   ),
  // ),
  timePickerTheme: const TimePickerThemeData(
    backgroundColor: darkAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (lightPrimary.withOpacity(0.3)),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (lightPrimary.withOpacity(0.6)),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: darkBG.withOpacity(0.3),
    margin: const EdgeInsets.all(15),
  ),
  snackBarTheme:
      SnackBarThemeData(backgroundColor: lightPrimary.withOpacity(0.6)),
);
