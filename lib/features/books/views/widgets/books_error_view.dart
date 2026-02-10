import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class BooksErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const BooksErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(re.w(32)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              builder: (_, v, child) => Transform.scale(
                scale: v,
                child: Opacity(opacity: v, child: child),
              ),
              child: Container(
                width: re.w(80),
                height: re.w(80),
                decoration: BoxDecoration(
                  color: cs.errorContainer.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cloud_off_rounded,
                  size: re.icon(40),
                  color: cs.error,
                ),
              ),
            ),
            SizedBox(height: re.h(24)),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: re.sp(18),
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: re.h(8)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: re.sp(14), color: cs.onSurfaceVariant),
            ),
            SizedBox(height: re.h(28)),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
