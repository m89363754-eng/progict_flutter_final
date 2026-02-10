import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class TagChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final IconData? icon;

  const TagChip({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final re = Responsive(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: re.w(7), vertical: re.h(2)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(re.r(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: re.icon(11), color: textColor),
            SizedBox(width: re.w(3)),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: re.sp(10.5),
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  const DetailChip({
    super.key,
    required this.icon,
    required this.label,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final re = Responsive(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: re.w(10), vertical: re.h(6)),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(re.r(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: re.icon(14), color: colorScheme.onSurfaceVariant),
          SizedBox(width: re.w(5)),
          Text(
            label,
            style: TextStyle(
              fontSize: re.sp(12),
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool loading;

  const ImagePlaceholder({
    super.key,
    required this.colorScheme,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final re = Responsive(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.3),
            colorScheme.surfaceContainerHighest,
          ],
        ),
      ),
      child: Center(
        child: loading
            ? SizedBox(
                width: re.w(22),
                height: re.w(22),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary.withValues(alpha: 0.5),
                ),
              )
            : Icon(
                Icons.menu_book_rounded,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                size: re.icon(28),
              ),
      ),
    );
  }
}
