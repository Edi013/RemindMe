import 'package:flutter/material.dart';

const Color lightPrimary = Color.fromARGB(255, 225, 225, 225);
const Color lightAccent = Color.fromARGB(255, 161, 127, 23);
const Color lightBG = Color.fromARGB(255, 238, 238, 238);

const Color darkPrimary = Color.fromARGB(255, 36, 36, 36);
const Color darkAccent = Color.fromARGB(255, 171, 160, 127);
const Color darkBG = Color.fromARGB(255, 18, 18, 18);

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
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: darkAccent,
        width: 2.0,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: lightPrimary,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: lightAccent,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(80),
    ),
  ),
  cardTheme: const CardTheme(
    color: lightPrimary,
    margin: EdgeInsets.all(50),
  ),
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
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: lightAccent,
        width: 2.0,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: darkPrimary,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: darkAccent,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(80),
    ),
  ),
  cardTheme: const CardTheme(
    color: darkPrimary,
    margin: EdgeInsets.all(50),
  ),
);
