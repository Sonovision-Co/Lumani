import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF4f46e5);
  static const Color primaryLight = Color(0xFFe0e7ff);
  static const Color success = Color(0xFF10b981);
  static const Color info = Color(0xFF3b82f6);
  static const Color infoBg = Color(0xFFeff6ff);
  static const Color textDark = Color(0xFF1f2937);
  static const Color textLight = Color(0xFF6b7280);
  static const Color bgApp = Color(0xFFf9fafb);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: bgApp,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primary,
      secondary: primaryLight,
      surface: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: textDark, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: textDark, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: textDark, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: textDark, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: textLight),
      bodyMedium: TextStyle(color: textLight),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bgApp,
      elevation: 0,
      iconTheme: IconThemeData(color: textDark),
      titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: primary,
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFd1d5db)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFd1d5db)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      hintStyle: const TextStyle(color: textLight),
    ),
  );
}
