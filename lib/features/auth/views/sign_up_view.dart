import 'package:flutter/material.dart';

import 'package:flutter_application_14/core/utils/responsive.dart';
import 'package:flutter_application_14/features/auth/AuthCubit/cubit/auth_cubit_cubit.dart';
import 'package:flutter_application_14/features/auth/utils/customsnackbar.dart';
import 'package:flutter_application_14/features/auth/views/sign_in_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/auth_card.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../utils/auth_validators.dart';
import '../viewmodels/sign_up_viewmodel.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: const _SignUpBody(),
    );
  }
}

class _SignUpBody extends StatelessWidget {
  const _SignUpBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpViewModel>();
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
                // ── Logo ───────────────────────────────────────────────
                Image.asset(AppStrings.logoPath, width: re.w(75)),
                SizedBox(height: re.h(16)),

                // ── Title ──────────────────────────────────────────────
                Text(
                  AppStrings.createAccount,
                  style: AppTextStyles.heading.copyWith(fontSize: re.sp(29)),
                ),
                SizedBox(height: re.h(4)),
                Text(
                  AppStrings.signUpSubtitle,
                  style: AppTextStyles.subtitle.copyWith(fontSize: re.sp(14)),
                ),
                SizedBox(height: re.h(40)),

                // ── Form Card ──────────────────────────────────────────
                AuthCard(
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: AppStrings.fullNameLabel,
                          hint: AppStrings.fullNameHint,
                          icon: Icons.person_outline,
                          controller: viewModel.nameController,
                          keyboardType: TextInputType.name,
                          validator: AuthValidators.validateName,
                        ),
                        const SizedBox(height: 16),
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
                        BlocListener<AuthCubitCubit, AuthCubitState>(
                          listener: (context, state) async {
                            if (state is AuthCubiSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackbar.success(
                                  "Success SignUp Now Sign In",
                                ),
                              );
                              await Future.delayed(Duration(seconds: 4));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInView(),
                                ),
                              );
                            } else if (state is AuthCubitfailur) {
                              CustomSnackbar.error(state.message);
                            } else {}
                          },
                          child: PrimaryButton(
                            label: AppStrings.signUp,
                            isLoading: viewModel.isLoading,
                            onPressed: () => _onSignUp(context, viewModel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: re.h(32)),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInView()),
                    );
                  },
                  child: const Text(
                    AppStrings.alreadyHaveAccount,
                    style: TextStyle(color: AppColors.link),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSignUp(
    BuildContext context,
    SignUpViewModel viewModel,
  ) async {
    final success = await viewModel.signUp(context);
    if (success && context.mounted) {}
  }
}
