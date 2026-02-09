import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles used across the application.
abstract final class AppTextStyles {
  static const String _fontFamily = 'Amiri';

  // ── Headings ───────────────────────────────────────────────────────────
  static const TextStyle heading = TextStyle(
    fontSize: 29,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  // ── Body ───────────────────────────────────────────────────────────────
  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    color: AppColors.textSecondary,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    color: AppColors.hintText,
  );

  // ── Buttons ────────────────────────────────────────────────────────────
  static const TextStyle buttonText = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static const TextStyle linkText = TextStyle(
    fontSize: 16,
    color: AppColors.link,
    decoration: TextDecoration.underline,
  );

  static const TextStyle dividerText = TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
  );
}
