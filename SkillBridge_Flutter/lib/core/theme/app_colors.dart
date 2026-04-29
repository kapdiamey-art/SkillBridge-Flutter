import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradients (Stays same for both themes)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Color primaryBlue = Color(0xFF6366F1);
  static const Color primaryPurple = Color(0xFFA855F7);

  // Dynamic Colors based on theme
  static Color background(bool isDark) => isDark ? const Color(0xFF0D0D12) : const Color(0xFFFFFFFF);
  static Color surface(bool isDark) => isDark ? const Color(0xFF1E1E24) : const Color(0xFFF7F7F9);
  static Color cardBg(bool isDark) => isDark ? const Color(0xFF16161D) : const Color(0xFFFFFFFF);
  
  static Color textPrimary(bool isDark) => isDark ? Colors.white : const Color(0xFF111827);
  static Color textSecondary(bool isDark) => isDark ? const Color(0xFFA0A0AB) : const Color(0xFF4B5563);
  static Color textMuted(bool isDark) => isDark ? const Color(0xFF71717A) : const Color(0xFF9CA3AF);

  // Static colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color border = Color(0xFF2E2E3A); // Used for dark, will adjust for light
  static Color borderColor(bool isDark) => isDark ? const Color(0xFF2E2E3A) : const Color(0xFFE5E7EB);
}
