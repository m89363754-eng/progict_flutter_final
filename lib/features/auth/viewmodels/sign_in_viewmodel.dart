import 'package:flutter/material.dart';
import 'package:flutter_application_14/features/auth/AuthCubit/cubit/auth_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<bool> signIn(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    context.read<AuthCubitCubit>().login(
      email: emailController.text,
      password: passwordController.text,
    );

    _setLoading(true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      return true;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void onFacebookLogin() {
    debugPrint('Facebook login tapped');
  }

  void onAppleLogin() {
    debugPrint('Apple login tapped');
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
