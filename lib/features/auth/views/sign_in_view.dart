import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/auth_card.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/social_login_button.dart';
import '../utils/auth_validators.dart';
import '../viewmodels/sign_in_viewmodel.dart';

/// Sign-in screen – allows returning users to authenticate.
class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInViewModel(),
      child: const _SignInBody(),
    );
  }
}

class _SignInBody extends StatelessWidget {
  const _SignInBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignInViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 48),
                // ── Logo ───────────────────────────────────────────────
                Image.asset(
                  AppStrings.logoPath,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                ),
                const SizedBox(height: 16),

                // ── Title ──────────────────────────────────────────────
                const Text(
                  AppStrings.welcomeBack,
                  style: AppTextStyles.heading,
                ),
                const SizedBox(height: 4),
                const Text(
                  AppStrings.signInSubtitle,
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 40),

                // ── Form Card ──────────────────────────────────────────
                AuthCard(
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: AppStrings.emailLabel,
                          hint: AppStrings.emailHint,
                          icon: Icons.email_outlined,
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: AuthValidators.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: AppStrings.passwordLabel,
                          hint: AppStrings.passwordHint,
                          icon: Icons.lock_outline,
                          obscureText: true,
                          controller: viewModel.passwordController,
                          validator: AuthValidators.validatePassword,
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          label: AppStrings.signIn,
                          isLoading: viewModel.isLoading,
                          onPressed: () => _onSignIn(context, viewModel),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          AppStrings.orContinueWith,
                          style: AppTextStyles.dividerText,
                        ),
                        const SizedBox(height: 20),

                        // ── Social Buttons ─────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SocialLoginButton(
                              icon: Icons.facebook,
                              iconColor: AppColors.facebook,
                              onPressed: viewModel.onFacebookLogin,
                            ),
                            SocialLoginButton(
                              icon: Icons.apple,
                              onPressed: viewModel.onAppleLogin,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ── Navigate to Sign Up ────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.noAccount),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.signUp),
                      child: Text(
                        AppStrings.signUp,
                        style: AppTextStyles.linkText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSignIn(
    BuildContext context,
    SignInViewModel viewModel,
  ) async {
    final success = await viewModel.signIn();
    if (success && context.mounted) {
      // TODO: Navigate to home screen on successful login.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sign-in successful!')));
    }
  }
}
