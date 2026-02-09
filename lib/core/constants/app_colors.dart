import 'package:flutter/material.dart';

/// Centralized color palette for the entire application.
abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF011B31);
  static const Color primaryLight = Color(0xFF0A3D6B);

  // ── Neutrals ───────────────────────────────────────────────────────────
  static const Color white = Colors.white;
  static const Color background = Colors.white;
  static const Color inputFill = Color(0xFFEDEAEA);
  static const Color border = Color(0xFFBDBDBD);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color hintText = Color(0xFF9E9E9E);

  // ── Accent ─────────────────────────────────────────────────────────────
  static const Color link = Colors.blue;
  static const Color facebook = Colors.blue;
  static const Color error = Color(0xFFD32F2F);

  // ── Shadows ────────────────────────────────────────────────────────────
  static Color shadow = Colors.black.withValues(alpha: 0.1);
}
