import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class AttendanceEmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const AttendanceEmptyState({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: re.w(40)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              builder: (_, v, child) => Transform.scale(scale: v, child: child),
              child: Container(
                width: re.w(120),
                height: re.w(120),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.people_outline_rounded,
                  size: re.icon(56),
                  color: cs.primary.withValues(alpha: 0.7),
                ),
              ),
            ),
            SizedBox(height: re.h(32)),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (_, v, child) => Opacity(
                opacity: v,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - v)),
                  child: child,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'No Attendees Yet',
                    style: TextStyle(
                      fontSize: re.sp(22),
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  SizedBox(height: re.h(12)),
                  Text(
                    'Start by adding your first attendee.\n'
                    'Tap the button below to get started.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: re.sp(15),
                      height: 1.5,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: re.h(36)),
                  FilledButton.tonalIcon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.person_add_alt_1_rounded),
                    label: const Text(
                      'Add First Attendee',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
