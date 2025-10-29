import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFA8C686);
  static const Color background = Color(0xFFFDFFF5);
  static const Color textPrimary = Color(0xFF171616);
  static const Color textSecondary = Color(0xFF848484);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: GoogleFonts.quicksand().fontFamily,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textSecondary,
      ),
      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.background,
      onPrimary: AppColors.textPrimary,
    ),
  );
}
