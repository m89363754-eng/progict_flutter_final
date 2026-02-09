import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A button styled for social login providers (e.g. Facebook, Apple).
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.icon,
    this.iconColor,
    this.onPressed,
  });

  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.inputFill,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: SizedBox(
          width: 100,
          height: 50,
          child: Icon(icon, color: iconColor, size: 30),
        ),
      ),
    );
  }
}
