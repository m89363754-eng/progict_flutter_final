import 'package:flutter/material.dart';
import '../utils/responsive.dart';

/// A beautiful blue gradient header used across all screens.
class BlueHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const BlueHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    final re = Responsive(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(re.r(28)),
          bottomRight: Radius.circular(re.r(28)),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x331565C0),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(re.w(24), re.h(16), re.w(16), re.h(22)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: re.sp(26),
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
