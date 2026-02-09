import 'package:flutter/material.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/auth/views/sign_up_view.dart';

/// Centralized named-route definitions.
abstract final class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  /// Route factory used by [MaterialApp.onGenerateRoute].
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return _buildRoute(const SignInView(), settings);
      case signUp:
        return _buildRoute(const SignUpView(), settings);
      default:
        return _buildRoute(const SignInView(), settings);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
