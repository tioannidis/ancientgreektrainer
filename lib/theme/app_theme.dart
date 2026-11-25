import 'package:flutter/material.dart';

class AppTheme {
  static const darkBg = Color(0xFF1A1612);
  static const darkSurface = Color(0xFF2A2420);
  static const darkCard = Color(0xFF342E28);
  static const darkInput = Color(0xFF241F1B);
  static const darkBorder = Color(0xFF4A4038);
  static const darkText = Color(0xFFE8DDD0);
  static const darkTextSecondary = Color(0xFFB8A898);

  static const lightBg = Color(0xFFF5F0E8);
  static const lightSurface = Color(0xFFEDE7DD);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightInput = Color(0xFFF0EBE3);
  static const lightBorder = Color(0xFFD4CDC2);
  static const lightText = Color(0xFF2A2420);
  static const lightTextSecondary = Color(0xFF5A5048);

  static const goldDark = Color(0xFFD4A853);
  static const goldLight = Color(0xFFA07020);
  static const correctDark = Color(0xFF6BBD6B);
  static const correctLight = Color(0xFF2D8A2D);
  static const wrongDark = Color(0xFFD46B6B);
  static const wrongLight = Color(0xFFC04040);
  static const blueDark = Color(0xFF6BA3D4);
  static const blueLight = Color(0xFF3070B0);

  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBg,
        colorScheme: const ColorScheme.dark(
          primary: goldDark,
          onPrimary: darkBg,
          secondary: blueDark,
          surface: darkSurface,
          onSurface: darkText,
          onSurfaceVariant: darkTextSecondary,
          outline: darkBorder,
          error: wrongDark,
        ),
        cardColor: darkCard,
        appBarTheme: const AppBarTheme(
          backgroundColor: darkBg,
          foregroundColor: darkText,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkInput,
          hintStyle: const TextStyle(color: darkTextSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: darkBorder),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: darkSurface,
          selectedColor: goldDark.withValues(alpha: 0.25),
          labelStyle: const TextStyle(color: darkText),
          side: const BorderSide(color: darkBorder),
        ),
      );

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBg,
        colorScheme: const ColorScheme.light(
          primary: goldLight,
          onPrimary: lightCard,
          secondary: blueLight,
          surface: lightSurface,
          onSurface: lightText,
          onSurfaceVariant: lightTextSecondary,
          outline: lightBorder,
          error: wrongLight,
        ),
        cardColor: lightCard,
        appBarTheme: const AppBarTheme(
          backgroundColor: lightBg,
          foregroundColor: lightText,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightInput,
          hintStyle: const TextStyle(color: lightTextSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: lightBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: lightBorder),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: lightSurface,
          selectedColor: goldLight.withValues(alpha: 0.25),
          labelStyle: const TextStyle(color: lightText),
          side: const BorderSide(color: lightBorder),
        ),
      );
}
