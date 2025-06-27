import 'package:flutter/material.dart';
import 'package:tick_note/core/utils/index.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    // app Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: R.colors.white,
      foregroundColor: R.colors.black,
      elevation: 20, // No shadow
      iconTheme: IconThemeData(color: Colors.black), // Icon color
      titleTextStyle: TextStyle(
        color: R.colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    //textTheme
    textTheme: TextTheme(
      titleLarge: TextStyle(),
      titleMedium: TextStyle(),
      titleSmall: TextStyle(),
      headlineLarge: TextStyle(),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      bodyLarge: TextStyle(fontSize: 22, color: Colors.black),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
    ),

    // input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      // enabledBorder
      enabledBorder: OutlineInputBorder(),
      // focusedBorder
      focusedBorder: OutlineInputBorder(),
    ),
    // Button Theme
    buttonTheme: ButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    ),
  );

  // Dark Theme
  static final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    // app Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: R.colors.black,
      foregroundColor: R.colors.white, // Text color
      elevation: 20, // No shadow
      iconTheme: IconThemeData(color: R.colors.white), // Icon color
      titleTextStyle: TextStyle(
        color: R.colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    //textTheme
    textTheme: TextTheme(
      titleLarge: TextStyle(),
      titleMedium: TextStyle(),
      titleSmall: TextStyle(),
      headlineLarge: TextStyle(),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      bodyLarge: TextStyle(fontSize: 22, color: Colors.white),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
    ),

    // input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      // enabledBorder
      enabledBorder: OutlineInputBorder(),
      // focusedBorder
      focusedBorder: OutlineInputBorder(),
    ),
    // Button Theme
    buttonTheme: ButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    ),
  );
}
