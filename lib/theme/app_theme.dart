import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xff3d5afe);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: Colors.grey.shade200,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),

    cardTheme: const CardThemeData(
      color: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: const Color(0xff121212),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff121212),
      foregroundColor: Colors.white,
    ),

    cardTheme: const CardThemeData(
      color: Color(0xff1e1e1e),
    ),
  );
}