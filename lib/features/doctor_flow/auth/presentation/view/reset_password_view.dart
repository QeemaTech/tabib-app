import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/app_validator.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/core/utilities/password_text_field.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/reset_password_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_state.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_view_model.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController passwordController;
  late TextEditingController confirmController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<DoctorAuthViewModel, AuthState>(
      listenWhen: (previous, current) =>
          previous.resetPasswordModel != current.resetPasswordModel,
      listener: (context, state) {
        if (state.resetPasswordModel.isError) {
          CustomToast.error(
            context,
            state.resetPasswordModel.errorMessage ?? '',
          );
        }
        if (state.resetPasswordModel.isLoaded) {
          final message = state.resetPasswordModel.data?.data?.message;
          CustomToast.success(
            context,
            (message != null && message.isNotEmpty)
                ? message
                : 'auth.resetPassword.success'.tr(),
          );
          Navigator.of(context).popUntil(
            (route) =>
                route.settings.name == AppRoutes.loginView || route.isFirst,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PositionedDirectional(
                start: 0,
                top: 60,
                child: CustomImageView(imagePath: AssetsManager.alba),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CustomImageView(imagePath: AssetsManager.logo),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          'auth.resetPassword.title'.tr(),
                          style: theme.medium20.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'auth.resetPassword.subtitle'.tr(),
                          style: theme.medium16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.textColor300,
                          ),
                        ),
                        const SizedBox(height: 24),
                        PasswordTextField(
                          controller: passwordController,
                          hintText: 'auth.resetPassword.newPassword'.tr(),
                          validator: AppValidator.password,
                        ),
                        const SizedBox(height: 16),
                        PasswordTextField(
                          controller: confirmController,
                          hintText: 'auth.resetPassword.confirmPassword'.tr(),
                          validator: (value) => AppValidator.confirmPassword(
                            value,
                            passwordController.text,
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              final authViewModel = context
                                  .read<DoctorAuthViewModel>();
                              final authState = authViewModel.state;
                              authViewModel.resetPassword(
                                DoctorResetPasswordRequest(
                                  phone: authState.phone,
                                  countryCode: authState.countryCode,
                                  code: authState.resetCode,
                                  resetToken: authState.resetToken,
                                  newPassword: passwordController.text,
                                ),
                              );
                            },
                            child: BlocBuilder<DoctorAuthViewModel, AuthState>(
                              builder: (context, state) {
                                return state.resetPasswordModel.isLoading
                                    ? SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: theme.whiteColor,
                                        ),
                                      )
                                    : Text('auth.resetPassword.save'.tr());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
