import 'package:flutter/material.dart';

class MyTheme {
  // Base colors for light theme
  static const Color whiteBackground = Colors.white;
  static const Color offWhite = Color(0xFFEFEFEF);
  static const Color inputText = Color.fromRGBO(44, 44, 44, 1);
  static const Color inputHint = Color.fromARGB(255, 114, 114, 114);
  static const Color cardShadow = Color.fromARGB(255, 159, 159, 159);

  // Base colors for dark theme
  static const String poppin = "Poppins";

  // Light theme using white/off-white palette
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteBackground,
    brightness: Brightness.light,
    primaryColor: offWhite,
    cardColor: offWhite,
    primaryColorDark: const Color.fromARGB(255, 0, 123, 255),
    hoverColor: const Color.fromARGB(255, 226, 232, 240),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        color: inputHint,
      ),
      contentPadding: EdgeInsets.all(10),
      labelStyle: TextStyle(color: inputText),
    ),
    iconTheme: const IconThemeData(
      color: inputText,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: inputText,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: inputText,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: inputText,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: inputText,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: poppin,
        color: inputText,
      ),
    ),
  );

  // Dark theme adjusted to use variations of black for input as well
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    cardColor: const Color(0xFF1C1C1C), // a slightly lighter black for cards
    primaryColorDark: Colors.black,
    hoverColor: const Color(0xFF292929),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xFF2C2C2C), // dark grey fill for input fields
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        color: Colors.grey, // a light grey for hint text
      ),
      contentPadding: EdgeInsets.all(10),
      labelStyle: TextStyle(color: Colors.white),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: poppin,
        color: Colors.white,
      ),
    ),
  );
}
