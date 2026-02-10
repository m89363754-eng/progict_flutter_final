// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_14/core/routes/app_routes.dart';

// class SplashView extends StatelessWidget {
//   const SplashView({super.key});

//   void _navigate(BuildContext context) {
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacementNamed(context, AppRoutes.signIn);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _navigate(context);

//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'Attendance App',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_14/core/routes/app_routes.dart';
import 'package:flutter_application_14/core/utils/responsive.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  void _navigateToSignIn(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigateToSignIn(context);
    final re = Responsive(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_available_rounded,
              size: re.icon(100),
              color: Colors.white,
            ),

            SizedBox(height: re.h(24)),

            Text(
              'Attendance App',
              style: TextStyle(
                fontSize: re.sp(32),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            SizedBox(height: re.h(8)),

            Text(
              'Track your presence with ease',
              style: TextStyle(fontSize: re.sp(16), color: Colors.white70),
            ),

            SizedBox(height: re.h(40)),

            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
