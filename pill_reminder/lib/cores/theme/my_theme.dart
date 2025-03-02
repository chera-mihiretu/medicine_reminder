import 'package:flutter/material.dart';

class MyTheme {
  // light theme
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color blueDark = Color(0xFF0065F9);
  static const Color grayBackground = Color(0xFFEAEAEA);
  static const Color skyBlue = Color(0xFFB1E4F9);
  static const Color blueLight = Color(0xFF60B7FF);
  static const Color blue = Color(0xFF229BFF);
  static const Color whiteTextColor = Color(0xFFFFFFFF);
  static const Color cardShadow = Color.fromARGB(255, 202, 202, 202);

  static const String poppin = "Poppins"; // dark theme
  static const Color backgroundColorNight = Color(0xFF121212);
  static const Color blueDarkNight = Color(0xFF003366);
  static const Color grayBackgroundNight = Color(0xFF1E1E1E);
  static const Color skyBlueNight = Color(0xFF4A90E2);
  static const Color blueLightNight = Color(0xFF3366FF);
  static const Color blueNight = Color(0xFF0055FF);
  static const Color whiteTextColorNight = Color(0xFFCCCCCC);
  static const Color cardShadowNight = Color.fromARGB(255, 50, 50, 50);
  static ThemeData lightThem = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    brightness: Brightness.light,
    primaryColor: blue,
    cardColor: blueDark,
    primaryColorDark: grayBackground,
    hoverColor: cardShadow,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: skyBlue,
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: whiteTextColor,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: whiteTextColor,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: poppin,
        color: whiteTextColor,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColorNight,
    brightness: Brightness.dark,
    primaryColor: blueNight,
    cardColor: blueDarkNight,
    primaryColorDark: grayBackgroundNight,
    hoverColor: cardShadowNight,
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: whiteTextColorNight,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: whiteTextColorNight,
        fontFamily: poppin,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: poppin,
        color: whiteTextColor,
      ),
    ),
  );
}
