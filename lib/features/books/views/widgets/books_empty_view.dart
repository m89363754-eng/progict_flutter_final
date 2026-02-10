import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class BooksEmptyView extends StatelessWidget {
  const BooksEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (_, v, child) => Transform.scale(scale: v, child: child),
            child: Icon(
              Icons.search_off_rounded,
              size: re.icon(64),
              color: cs.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ),
          SizedBox(height: re.h(16)),
          Text(
            'No books found',
            style: TextStyle(
              fontSize: re.sp(18),
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: re.h(8)),
          Text(
            'Try a different search term',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: re.sp(14)),
          ),
        ],
      ),
    );
  }
}
