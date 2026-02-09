import 'package:flutter/material.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/auth/views/sign_up_view.dart';
import '../navigation/main_shell.dart';

abstract final class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String mainview = '/mainview';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return _buildRoute(const SignInView(), settings);
      case signUp:
        return _buildRoute(const SignUpView(), settings);
      case mainview:
        return _buildRoute(const MainShell(), settings);
      default:
        return _buildRoute(const MainShell(), settings);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
