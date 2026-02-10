import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class BooksShimmerList extends StatelessWidget {
  const BooksShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(re.w(16), re.h(8), re.w(16), re.h(16)),
      itemCount: 6,
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.only(bottom: re.h(10)),
        child: _ShimmerTile(colorScheme: cs, re: re),
      ),
    );
  }
}

class _ShimmerTile extends StatefulWidget {
  final ColorScheme colorScheme;
  final Responsive re;
  const _ShimmerTile({required this.colorScheme, required this.re});

  @override
  State<_ShimmerTile> createState() => _ShimmerTileState();
}

class _ShimmerTileState extends State<_ShimmerTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = widget.colorScheme;
    final re = widget.re;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final opacity = 0.3 + 0.3 * (0.5 + 0.5 * cos(_ctrl.value * 2 * pi));
        return Opacity(
          opacity: opacity,
          child: Container(
            height: re.h(120),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(re.r(16)),
            ),
            child: Row(
              children: [
                Container(
                  width: re.w(80),
                  margin: EdgeInsets.all(re.w(12)),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainer,
                    borderRadius: BorderRadius.circular(re.r(10)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: re.h(16),
                      horizontal: re.w(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bar(cs, re, double.infinity, re.h(14)),
                        SizedBox(height: re.h(10)),
                        _bar(cs, re, re.w(120), re.h(12)),
                        const Spacer(),
                        _bar(cs, re, re.w(180), re.h(10)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bar(ColorScheme cs, Responsive re, double w, double h) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(re.r(4)),
      ),
    );
  }
}
