import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/app_validator.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/send_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view/otp_bottom_sheet.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_state.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    final authViewModel = context.read<DoctorAuthViewModel>();
    phoneController = TextEditingController(
      text: authViewModel.state.phone ?? '',
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (authViewModel.state.countryCode == null) {
        authViewModel.setCountryCode('+39');
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void _showResetSheet(BuildContext context) {
    final authViewModel = context.read<DoctorAuthViewModel>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: authViewModel,
        child: const OtpBottomSheet(purpose: OtpPurpose.passwordReset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<DoctorAuthViewModel, AuthState>(
      listenWhen: (previous, current) =>
          previous.forgotPasswordModel != current.forgotPasswordModel,
      listener: (context, state) {
        final authViewModel = context.read<DoctorAuthViewModel>();
        if (state.forgotPasswordModel.isError && state.openResetSheet) {
          authViewModel.setOpenResetSheet(false);
          CustomToast.error(
            context,
            state.forgotPasswordModel.errorMessage ?? '',
          );
        }
        if (state.forgotPasswordModel.isLoaded && state.openResetSheet) {
          authViewModel.setOpenResetSheet(false);
          final message = state.forgotPasswordModel.data?.data?.message;
          if (message != null && message.isNotEmpty) {
            CustomToast.success(context, message);
          }
          _showResetSheet(context);
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
                          'auth.forgotPassword.title'.tr(),
                          style: theme.medium20.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'auth.forgotPassword.subtitle'.tr(),
                          style: theme.medium16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.textColor300,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'auth.login.phoneNumber'.tr(),
                          style: theme.bold18.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            BlocBuilder<DoctorAuthViewModel, AuthState>(
                              builder: (context, state) {
                                final countryCode = state.countryCode;
                                return countryCode != null
                                    ? Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: theme.whiteColor,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          countryCode,
                                          style: theme.bold12,
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextFormField(
                                validator: AppValidator.phone,
                                hintText: 'auth.signUp.enterPhone'.tr(),
                                controller: phoneController,
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 5,
                                  top: 5,
                                  bottom: 5,
                                ),
                                keyboardType: TextInputType.phone,
                                suffixWidget: CountryCodePicker(
                                  margin: const EdgeInsets.all(5),
                                  flagWidth: 16,
                                  showFlag: true,
                                  onChanged: (country) {
                                    context
                                        .read<DoctorAuthViewModel>()
                                        .setCountryCode(country.dialCode ?? '');
                                  },
                                  initialSelection: 'IT',
                                  favorite: const ['+39', 'FR'],
                                  showOnlyCountryWhenClosed: true,
                                  alignLeft: false,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              final authViewModel = context
                                  .read<DoctorAuthViewModel>();
                              authViewModel.forgotPassword(
                                DoctorSendOtpRequest(
                                  phone: phoneController.text.trim(),
                                  countryCode: authViewModel.state.countryCode,
                                  role: authViewModel.state.role,
                                ),
                                openSheet: true,
                              );
                            },
                            child: BlocBuilder<DoctorAuthViewModel, AuthState>(
                              builder: (context, state) {
                                return state.forgotPasswordModel.isLoading
                                    ? SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: theme.whiteColor,
                                        ),
                                      )
                                    : Text('auth.forgotPassword.sendCode'.tr());
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
