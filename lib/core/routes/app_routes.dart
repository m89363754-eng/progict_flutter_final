import 'package:flutter/material.dart';
import 'package:flutter_application_14/features/Into_of_app/onboarding_view.dart';
import 'package:flutter_application_14/features/Into_of_app/splach_sreen.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/auth/views/sign_up_view.dart';
import '../navigation/main_shell.dart';

abstract final class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String mainview = '/mainview';
  static const String splachscreen = '/splachscreen ';
  static const String onbaording = '/onbaording ';
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splachscreen:
        return _buildRoute(const SplashView(), settings);
      case onbaording:
        return _buildRoute(const OnboardingView(), settings);
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
