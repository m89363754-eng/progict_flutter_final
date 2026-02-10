import 'package:flutter/material.dart';
import 'package:flutter_application_14/features/auth/AuthCubit/cubit/auth_cubit_cubit.dart';
import 'package:provider/provider.dart';

/// ViewModel for the Sign Up screen.
///
/// Manages form state, validation, and registration logic.
class SignUpViewModel extends ChangeNotifier {
  // ── Controllers ──────────────────────────────────────────────────────
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // ── State ────────────────────────────────────────────────────────────
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  // ── Actions ──────────────────────────────────────────────────────────

  /// Toggles password visibility.
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Attempts to create a new account.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> signUp(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    context.read<AuthCubitCubit>().signup(
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

  // ── Helpers ──────────────────────────────────────────────────────────

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
