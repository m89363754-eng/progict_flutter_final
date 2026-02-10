import 'package:flutter/material.dart';

/// Centralized color palette for the entire application.
abstract final class AppColors {
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);

  static const Color white = Colors.white;
  static const Color background = Colors.white;
  static const Color inputFill = Color(0xFFE8EEF8);
  static const Color border = Color(0xFFB0BEC5);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF546E7A);
  static const Color hintText = Color(0xFF90A4AE);

  static const Color link = Color(0xFF1976D2);
  static const Color facebook = Color(0xFF1877F2);
  static const Color error = Color(0xFFD32F2F);

  static Color shadow = Colors.black.withValues(alpha: 0.1);
}
