import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';

const Color lightPrimary = Color.fromARGB(255, 225, 225, 225);
const Color lightAccent = accent;
const Color lightBG = Color.fromARGB(255, 192, 192, 192);

const Color accent = Color(0xFF468c98);
const Color red = Color.fromARGB(0, 255, 0, 0);
const Color darkPrimary = Color.fromARGB(255, 85, 162, 175);
const Color darkAccent = accent;
const Color darkBG = smokeAccent; //Color(0xFF3C4A6D);

const Color black = Color(0xFF121212);
const Color white = Color(0xFFFFFFFF);
const Color smokeWhite = Color.fromARGB(255, 195, 195, 195);
const Color smokeAccent = Color.fromARGB(255, 67, 101, 107);
const Color grey = Color(0xFF2E2E2E);

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.light,
    primary: darkPrimary,
    secondary: darkAccent,
    background: darkBG,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: white), // Example text style
    bodyLarge: TextStyle(fontSize: 16, color: white), // Example text style
    // Define other text styles as needed
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: white, // Color of the text cursor
    selectionColor: smokeAccent, // Color of the text selection highlight
    selectionHandleColor: smokeAccent, // Color of the text selection handles
  ),
  useMaterial3: true,
  // materialTapTargetSize: MaterialTapTargetSize.padded,
  cardTheme: CardTheme(
    color: darkBG, //darkAccent.withOpacity(0.85),
    margin: const EdgeInsets.all(50),
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
  materialTapTargetSize: MaterialTapTargetSize.padded,
);
// final ThemeData lightTheme = ThemeData(
//   colorScheme: ColorScheme.fromSwatch().copyWith(
//     primary: lightPrimary,
//     onBackground: lightBG,
//     secondary: lightAccent,
//     brightness: Brightness.light,
//   ),
//   useMaterial3: false,
//   splashColor: lightAccent,
//   primaryColor: lightPrimary,
//   scaffoldBackgroundColor: lightBG,
//   navigationRailTheme: const NavigationRailThemeData(
//     backgroundColor: lightBG,
//   ),
//   datePickerTheme: const DatePickerThemeData(
//     backgroundColor: darkAccent,
//     headerBackgroundColor: darkBG,
//   ),
//   // tabBarTheme: const TabBarTheme(
//   //   labelColor: Colors.black,
//   //   indicator: UnderlineTabIndicator(
//   //     borderSide: BorderSide(
//   //       color: darkAccent,
//   //       width: 2.0,
//   //     ),
//   //   ),
//   // ),

//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(
//       fontSize: kFontSize + 5,
//       color: Color.fromARGB(255, 255, 255, 255),
//     ),
//     bodySmall: TextStyle(
//       fontSize: kFontSize - 5,
//       color: Color.fromARGB(255, 255, 255, 255),
//     ),
//     bodyMedium: TextStyle(
//       fontSize: kFontSize,
//       color: Color.fromARGB(255, 255, 255, 255),
//     ),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(darkPrimary)),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all<Color>(
//         (darkPrimary),
//       ),
//     ),
//   ),
//   cardTheme: CardTheme(
//     color: darkBG.withOpacity(0.3), //darkAccent.withOpacity(0.85),
//     margin: const EdgeInsets.all(50),
//   ),
//   snackBarTheme: const SnackBarThemeData(backgroundColor: darkPrimary),
// );

// final ThemeData darkTheme = ThemeData(
//   colorScheme: ColorScheme.fromSwatch().copyWith(
//     primary: darkPrimary,
//     onBackground: darkBG,
//     secondary: darkAccent,
//     brightness: Brightness.dark,
//   ),
//   useMaterial3: true,
//   splashColor: darkAccent,
//   primaryColor: darkPrimary,
//   scaffoldBackgroundColor: darkBG,
//   navigationRailTheme: const NavigationRailThemeData(
//     backgroundColor: darkBG,
//   ),
//   datePickerTheme: DatePickerThemeData(
//       backgroundColor: darkAccent,
//       headerBackgroundColor: darkBG.withOpacity(0.5)),
//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(
//       fontSize: kFontSize + 5,
//       color: Colors.white,
//     ),
//     bodySmall: TextStyle(
//       fontSize: kFontSize - 5,
//       color: Colors.white,
//     ),
//     bodyMedium: TextStyle(
//       fontSize: kFontSize,
//       color: Colors.white,
//     ),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all<Color>(
//         (lightPrimary.withOpacity(0.3)),
//       ),
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all<Color>(
//         (lightPrimary.withOpacity(0.6)),
//       ),
//     ),
//   ),
//   cardTheme: CardTheme(
//     color: darkBG.withOpacity(0.3), //darkAccent.withOpacity(0.85),
//     margin: const EdgeInsets.all(50),
//   ),
//   snackBarTheme:
//       SnackBarThemeData(backgroundColor: lightPrimary.withOpacity(0.6)),
// );
