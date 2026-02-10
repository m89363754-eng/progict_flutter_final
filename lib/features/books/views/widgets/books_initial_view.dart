import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class BooksInitialView extends StatelessWidget {
  const BooksInitialView({super.key});

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
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            builder: (_, v, child) => Transform.scale(scale: v, child: child),
            child: SizedBox(
              width: re.w(150),
              height: re.h(130),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: re.w(120),
                    height: re.w(120),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.primaryContainer.withValues(alpha: 0.25),
                    ),
                  ),
                  Transform.rotate(
                    angle: -0.2,
                    child: _BookSpine(
                      color: cs.primary.withValues(alpha: 0.5),
                      width: re.w(48),
                      height: re.h(68),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(re.w(8), re.h(-4)),
                    child: _BookSpine(
                      color: cs.primaryContainer,
                      width: re.w(48),
                      height: re.h(74),
                    ),
                  ),
                  Transform.rotate(
                    angle: 0.15,
                    child: Transform.translate(
                      offset: Offset(re.w(16), re.h(2)),
                      child: _BookSpine(
                        color: cs.primary,
                        width: re.w(48),
                        height: re.h(66),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: re.h(24)),
          Text(
            'Discover Books',
            style: TextStyle(
              fontSize: re.sp(20),
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: re.h(8)),
          Text(
            'Search for any topic above',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: re.sp(14)),
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
