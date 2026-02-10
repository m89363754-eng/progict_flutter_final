import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';

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
    final re = Responsive(context);
    return Material(
      color: AppColors.inputFill,
      borderRadius: BorderRadius.circular(re.r(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(re.r(15)),
        onTap: onPressed,
        child: SizedBox(
          width: re.w(100),
          height: re.h(50),
          child: Icon(icon, color: iconColor, size: re.icon(30)),
        ),
      ),
    );
  }
}
