import 'package:flutter/material.dart';

/// ViewModel for the Sign In screen.
///
/// Manages form state, validation, and authentication logic.
class SignInViewModel extends ChangeNotifier {
  // ── Controllers ──────────────────────────────────────────────────────
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

  /// Attempts to sign in the user.
  ///
  /// Returns `true` on success, `false` otherwise.
  Future<bool> signIn() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;

    _setLoading(true);

    try {
      // TODO: Replace with actual authentication service call.
      await Future.delayed(const Duration(seconds: 1));

      debugPrint('✅ Sign-in successful for: ${emailController.text.trim()}');
      return true;
    } catch (e) {
      debugPrint('❌ Sign-in failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Handles Facebook login tap.
  void onFacebookLogin() {
    // TODO: Implement Facebook login.
    debugPrint('Facebook login tapped');
  }

  /// Handles Apple login tap.
  void onAppleLogin() {
    // TODO: Implement Apple login.
    debugPrint('Apple login tapped');
  }

  // ── Helpers ──────────────────────────────────────────────────────────

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
