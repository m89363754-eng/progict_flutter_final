import 'package:flutter/material.dart';
import 'package:flutter_application_14/core/navigation/main_shell.dart';
import 'package:flutter_application_14/core/utils/responsive.dart';
import 'package:flutter_application_14/features/auth/AuthCubit/cubit/auth_cubit_cubit.dart';
import 'package:flutter_application_14/features/auth/utils/customsnackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final re = Responsive(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: re.horizontalPadding,
            child: Column(
              children: [
                SizedBox(height: re.h(48)),
                Image.asset(AppStrings.logoPath, width: re.w(75)),
                SizedBox(height: re.h(16)),

                Text(
                  AppStrings.welcomeBack,
                  style: AppTextStyles.heading.copyWith(fontSize: re.sp(29)),
                ),
                SizedBox(height: re.h(4)),
                Text(
                  AppStrings.signInSubtitle,
                  style: AppTextStyles.subtitle.copyWith(fontSize: re.sp(14)),
                ),
                SizedBox(height: re.h(40)),

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
                        SizedBox(height: re.h(24)),
                        BlocConsumer<AuthCubitCubit, AuthCubitState>(
                          listener: (context, state) {
                            if (state is AuthCubiSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackbar.success("Success SignIn"),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => MainShell()),
                              );
                            }

                            if (state is AuthCubitfailur) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackbar.error(state.message),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthCubitLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return PrimaryButton(
                              label: AppStrings.signIn,
                              isLoading: viewModel.isLoading,
                              onPressed: () => _onSignIn(context, viewModel),
                            );
                          },
                        ),

                        const SizedBox(height: 20),
                        Text(
                          AppStrings.orContinueWith,
                          style: AppTextStyles.dividerText.copyWith(
                            fontSize: re.sp(11),
                          ),
                        ),
                        SizedBox(height: re.h(20)),

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

                SizedBox(height: re.h(32)),

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
    final success = await viewModel.signIn(context);
    if (success && context.mounted) {}
  }
}
