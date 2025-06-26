import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    // app Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black, // Text color
      elevation: 0, // No shadow
      iconTheme: IconThemeData(color: Colors.black), // Icon color
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
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
      backgroundColor: Colors.black,
      foregroundColor: Colors.white, // Text color
      elevation: 0, // No shadow
      iconTheme: IconThemeData(color: Colors.white), // Icon color
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
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
