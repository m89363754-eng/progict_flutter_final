import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';

/// A card container with shadow, used for auth forms.
class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final re = Responsive(context);
    return Container(
      width: re.isTablet ? re.w(320) : double.infinity,
      constraints: BoxConstraints(maxWidth: re.maxContentWidth),
      padding: EdgeInsets.symmetric(vertical: re.h(32), horizontal: re.w(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(re.r(20)),
        border: Border.all(width: 0.2, color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
