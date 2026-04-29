import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0D0D12);
  static const Color surface = Color(0xFF1E1E24);
  static const Color cardBg = Color(0xFF16161D);

  // Primaries
  static const Color primaryBlue = Color(0xFF4285F4);
  static const Color primaryPurple = Color(0xFF9C27B0);
  static const Color accent = Color(0xFF00D2FF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF1E1E24), Color(0xFF16161D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B0B5);
  static const Color textMuted = Color(0xFF6E6E75);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
}
