import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF0F172A);
  static const Color accent = Color(0xFF38BDF8);
  static const Color background = Color(0xFF0A0F1E);
  static const Color card = Color(0x1AFFFFFF);

  // Additional properties for compatibility
  static const Color darkBackground = Color(0xFF0A0F1E);
  static const Color primaryColor = Color(0xFF38BDF8);

  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ).copyWith(secondary: accent),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ).copyWith(secondary: accent),
    scaffoldBackgroundColor: background,
    cardColor: card,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 0,
    ),
  );
}
