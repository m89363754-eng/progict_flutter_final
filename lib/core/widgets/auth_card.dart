import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A card container with shadow, used for auth forms.
class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
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
