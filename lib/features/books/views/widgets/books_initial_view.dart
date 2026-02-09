import 'package:flutter/material.dart';

class BooksInitialView extends StatelessWidget {
  const BooksInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            builder: (_, v, child) => Transform.scale(scale: v, child: child),
            child: SizedBox(
              width: 150,
              height: 130,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.primaryContainer.withValues(alpha: 0.25),
                    ),
                  ),
                  Transform.rotate(
                    angle: -0.2,
                    child: _BookSpine(
                      color: cs.primary.withValues(alpha: 0.5),
                      width: 48,
                      height: 68,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(8, -4),
                    child: _BookSpine(
                      color: cs.primaryContainer,
                      width: 48,
                      height: 74,
                    ),
                  ),
                  Transform.rotate(
                    angle: 0.15,
                    child: Transform.translate(
                      offset: const Offset(16, 2),
                      child: _BookSpine(
                        color: cs.primary,
                        width: 48,
                        height: 66,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Discover Books',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Search for any topic above',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _BookSpine extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  const _BookSpine({
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width * 0.5,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: width * 0.35,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
