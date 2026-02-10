import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class AttendanceSummaryBar extends StatelessWidget {
  final int present;
  final int absent;
  final int total;

  const AttendanceSummaryBar({
    super.key,
    required this.present,
    required this.absent,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (_, v, child) => Transform.translate(
        offset: Offset(0, 20 * (1 - v)),
        child: Opacity(opacity: v, child: child),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(re.w(16), re.h(12), re.w(16), re.h(4)),
        padding: EdgeInsets.symmetric(horizontal: re.w(20), vertical: re.h(16)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cs.primaryContainer,
              cs.primaryContainer.withValues(alpha: 0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: cs.primaryContainer.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _StatChip(
              label: 'Total',
              value: '$total',
              icon: Icons.groups_rounded,
              color: cs.onPrimaryContainer,
            ),
            const Spacer(),
            _StatChip(
              label: 'Present',
              value: '$present',
              icon: Icons.check_circle_rounded,
              color: const Color(0xFF2E7D32),
            ),
            const SizedBox(width: 24),
            _StatChip(
              label: 'Absent',
              value: '$absent',
              icon: Icons.cancel_rounded,
              color: const Color(0xFFC62828),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Text(
                value,
                key: ValueKey(value),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
