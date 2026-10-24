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
import 'package:tabib_app/core/utilities/password_text_field.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view/otp_bottom_sheet.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_state.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_view_model.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/widgets/lang_select.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final authViewModel = context.read<DoctorAuthViewModel>();
      if (authViewModel.state.countryCode == null) {
        authViewModel.setCountryCode('+39');
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<DoctorAuthViewModel, AuthState>(
      listenWhen: (previous, current) =>
          previous.registerModel != current.registerModel,
      listener: (context, state) {
        if (state.registerModel.isError) {
          CustomToast.error(context, state.registerModel.errorMessage ?? '');
        }
        if (state.registerModel.isLoaded) {
          final authViewModel = context.read<DoctorAuthViewModel>();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => BlocProvider.value(
              value: authViewModel,
              child: const OtpBottomSheet(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.whiteColor,
        body: SafeArea(
          child: Stack(
            children: [
              PositionedDirectional(
                start: 0,
                top: 60,
                child: CustomImageView(imagePath: AssetsManager.alba),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CustomImageView(imagePath: AssetsManager.logo),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          "auth.signUp.title".tr(),
                          style: theme.medium20.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "auth.signUp.description".tr(),
                          style: theme.medium16.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.textColor300,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          validator: AppValidator.name,
                          controller: nameController,
                          hintText: "auth.signUp.enterName".tr(),
                          keyboardType: TextInputType.text,
                        ),
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
                                          boxShadow: [
                                            BoxShadow(
                                              color: theme.primaryColor
                                                  .withValues(alpha: 0.1),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                            BoxShadow(
                                              color: theme.primaryColor
                                                  .withValues(alpha: 0.1),
                                              blurRadius: 10,
                                              offset: const Offset(-2, 0),
                                            ),
                                          ],
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
                                hintText: "auth.signUp.enterPhone".tr(),
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
                        CustomTextFormField(
                          controller: emailController,
                          validator: AppValidator.email,
                          hintText: "auth.signUp.enterEmail".tr(),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        PasswordTextField(
                          controller: passwordController,
                          hintText: "auth.signUp.enterPassword".tr(),
                          validator: AppValidator.password,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "auth.signUp.languageLabel".tr(),
                          style: theme.bold18.copyWith(fontSize: 16),
                        ),
                        Text(
                          "auth.signUp.languageDescription".tr(),
                          style: theme.medium13.copyWith(
                            color: theme.textColor200,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        LanguageSelector(
                          onLanguageSelected: (String value) {
                            context
                                .read<DoctorAuthViewModel>()
                                .setPreferredLanguage(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final authViewModel = context
                                  .read<DoctorAuthViewModel>();
                              final registerRequest = DoctorRegisterRequest(
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                fullName: nameController.text.trim(),
                                password: passwordController.text,
                                preferredLanguage:
                                    authViewModel.state.preferredLanguage,
                                countryCode: authViewModel.state.countryCode,
                              );
                              authViewModel.register(registerRequest);
                            }
                          },
                          child: BlocBuilder<DoctorAuthViewModel, AuthState>(
                            builder: (context, state) {
                              return state.registerModel.isLoading
                                  ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: theme.whiteColor,
                                      ),
                                    )
                                  : Text("auth.signUp.signUpButton".tr());
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
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
