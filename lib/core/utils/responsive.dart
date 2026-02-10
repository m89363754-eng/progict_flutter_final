import 'package:flutter/material.dart';

/// Responsive utility that scales sizes based on screen dimensions.
///
/// Design baseline: 375 × 812 (iPhone X).
/// Usage:
/// ```dart
/// final r = Responsive(context);
/// SizedBox(height: r.h(16));
/// Text('Hello', style: TextStyle(fontSize: r.sp(22)));
/// EdgeInsets.symmetric(horizontal: r.w(24));
/// ```
class Responsive {
  final BuildContext context;
  late final Size _size;

  Responsive(this.context) : _size = MediaQuery.sizeOf(context);

  static const double _designWidth = 375;
  static const double _designHeight = 812;

  /// Screen width.
  double get screenWidth => _size.width;

  /// Screen height.
  double get screenHeight => _size.height;

  /// True when width >= 600 (tablet).
  bool get isTablet => _size.width >= 600;

  /// True when width >= 1024 (desktop).
  bool get isDesktop => _size.width >= 1024;

  /// Scale a horizontal value (padding, width, etc.) proportionally.
  double w(double value) => value * (_size.width / _designWidth);

  /// Scale a vertical value (padding, height, spacing) proportionally.
  double h(double value) => value * (_size.height / _designHeight);

  /// Scale font size — uses width ratio but clamped to avoid extremes.
  double sp(double value) {
    final scale = _size.width / _designWidth;
    return value * scale.clamp(0.8, 1.4);
  }

  /// Scale a radius or border value.
  double r(double value) => value * (_size.width / _designWidth);

  /// Scale icon size.
  double icon(double value) {
    final scale = _size.width / _designWidth;
    return value * scale.clamp(0.85, 1.3);
  }

  /// Content max width — constrains content on large screens.
  double get maxContentWidth =>
      isDesktop ? 600 : (isTablet ? 500 : _size.width);

  /// Symmetric horizontal padding that adapts to screen size.
  EdgeInsets get horizontalPadding {
    if (isDesktop) {
      return EdgeInsets.symmetric(horizontal: (_size.width - 600) / 2);
    }
    if (isTablet) return EdgeInsets.symmetric(horizontal: w(40));
    return EdgeInsets.symmetric(horizontal: w(24));
  }
}
