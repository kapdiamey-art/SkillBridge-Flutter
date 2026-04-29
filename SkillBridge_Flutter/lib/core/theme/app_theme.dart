import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData theme(bool isDark) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: AppColors.background(isDark),
      primaryColor: AppColors.primaryBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryPurple,
        surface: AppColors.surface(isDark),
        background: AppColors.background(isDark),
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        TextTheme(
          displayLarge: TextStyle(color: AppColors.textPrimary(isDark)),
          displayMedium: TextStyle(color: AppColors.textPrimary(isDark)),
          bodyLarge: TextStyle(color: AppColors.textPrimary(isDark)),
          bodyMedium: TextStyle(color: AppColors.textSecondary(isDark)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary(isDark),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary(isDark)),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg(isDark),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.borderColor(isDark), width: 1),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.background(isDark),
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textMuted(isDark),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
