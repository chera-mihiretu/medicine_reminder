import 'package:flutter/material.dart';

class MyTheme {
  static const String fontFamily = 'Poppins';

  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF0D47A1), // Very dark blue
    primaryColorLight: const Color(0xFFE3F2FD), // Very light blue
    primaryColorDark:
        const Color.fromARGB(255, 167, 192, 230), // Very dark blue
    scaffoldBackgroundColor: Colors.white, // White background
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF0D47A1), // Very dark blue
      textTheme: ButtonTextTheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
        ),
        foregroundColor: Colors.white, // Set text color to white
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: fontFamily,
        ),
        foregroundColor: Colors.white, // Set text color to white
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 25, 108, 231), // Very dark blue
      titleTextStyle: TextStyle(
        color: Colors.white, // Text on dark blue should be white
        fontSize: 20.0,
        fontFamily: fontFamily,
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: Colors.black, // Text on light blue should be black
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        color: Colors.black, // Text on light blue should be black
        fontFamily: fontFamily,
      ),
      displayLarge: TextStyle(
        color: Colors.white, // Text on dark blue should be white
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        color: Colors.white, // Text on dark blue should be white
        fontFamily: fontFamily,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF0D47A1), // Very dark blue
    ),
  );
}
