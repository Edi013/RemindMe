import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';

const Color lightPrimary = Color.fromARGB(255, 225, 225, 225);
const Color lightAccent = accent;
const Color lightBG = Color.fromARGB(255, 192, 192, 192);

const Color accent = Color.fromARGB(255, 161, 127, 23);

const Color darkPrimary = Color.fromARGB(255, 73, 73, 73);
const Color darkAccent = accent;
const Color darkBG = Color.fromARGB(255, 53, 53, 53);

const Color smokeWhite = Color(0xffF5F5F5);

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: lightPrimary,
    onBackground: lightBG,
    secondary: lightAccent,
    brightness: Brightness.light,
  ),
  useMaterial3: false,
  splashColor: lightAccent,
  primaryColor: lightPrimary,
  scaffoldBackgroundColor: lightBG,
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: lightBG,
  ),
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: darkAccent,
    headerBackgroundColor: darkBG,
  ),
  // tabBarTheme: const TabBarTheme(
  //   labelColor: Colors.black,
  //   indicator: UnderlineTabIndicator(
  //     borderSide: BorderSide(
  //       color: darkAccent,
  //       width: 2.0,
  //     ),
  //   ),
  // ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: kFontSize + 5,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    bodySmall: TextStyle(
      fontSize: kFontSize - 5,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    bodyMedium: TextStyle(
      fontSize: kFontSize,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(darkPrimary)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (darkPrimary),
      ),
    ),
  ),
  //checkboxTheme: ChechBoxTheme(),
  // cardTheme: CardTheme(
  //   color: lightAccent.withOpacity(0.6),
  //   margin: const EdgeInsets.all(50),
  // ),
  cardTheme: CardTheme(
    color: darkBG.withOpacity(0.3), //darkAccent.withOpacity(0.85),
    margin: const EdgeInsets.all(50),
  ),
  snackBarTheme: const SnackBarThemeData(backgroundColor: darkPrimary),
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
  datePickerTheme: DatePickerThemeData(
      backgroundColor: darkAccent,
      headerBackgroundColor: darkBG.withOpacity(0.5)),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: kFontSize + 5,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: kFontSize - 5,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: kFontSize,
      color: Colors.white,
    ),
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
    color: darkBG.withOpacity(0.3), //darkAccent.withOpacity(0.85),
    margin: const EdgeInsets.all(50),
  ),
  snackBarTheme:
      SnackBarThemeData(backgroundColor: lightPrimary.withOpacity(0.6)),
);
