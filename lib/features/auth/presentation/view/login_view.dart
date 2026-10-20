import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/auth/presentation/view/otp_bottom_sheet.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_state.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void _showOtpSheet(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: authViewModel,
        child: const OtpBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<AuthViewModel, AuthState>(
      listenWhen: (previous, current) =>
          previous.loginModel != current.loginModel,
      listener: (context, state) {
        if (state.loginModel.isError) {
          CustomToast.error(context, state.loginModel.errorMessage ?? '');
        }
        if (state.loginModel.isLoaded) {
          _showOtpSheet(context);
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 66),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CustomImageView(imagePath: AssetsManager.logo),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          "auth.login.welcomeBack".tr(),
                          style: theme.medium20.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "auth.login.subtitle".tr(),
                          style: theme.medium16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.textColor300,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "auth.login.phoneNumber".tr(),
                          style: theme.bold18.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            BlocBuilder<AuthViewModel, AuthState>(
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
                              //  validator: AppValidator.phone,
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
                                        .read<AuthViewModel>()
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
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              final authViewModel =
                                  context.read<AuthViewModel>();
                              authViewModel.sendOtp(
                                LoginRequest(
                                  phone: phoneController.text.trim(),
                                  countryCode: authViewModel.state.countryCode,
                                  role: authViewModel.state.role,
                                ),
                              );
                            },
                            child: BlocBuilder<AuthViewModel, AuthState>(
                              builder: (context, state) {
                                return state.loginModel.isLoading
                                    ? SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: theme.whiteColor,
                                        ),
                                      )
                                    : Text("auth.login.loginButton".tr());
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
