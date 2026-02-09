import 'package:flutter/material.dart';

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
  Future<bool> signUp() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;

    _setLoading(true);

    try {
      // TODO: Replace with actual registration service call.
      await Future.delayed(const Duration(seconds: 1));

      debugPrint('✅ Account created for: ${emailController.text.trim()}');
      return true;
    } catch (e) {
      debugPrint('❌ Sign-up failed: $e');
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
