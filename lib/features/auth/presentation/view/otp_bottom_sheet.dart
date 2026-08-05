import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_state.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_view_model.dart';

import 'otp_widget.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({super.key});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  static const int _defaultResendAfter = 30;

  Timer? _timer;
  late int _resendAfter;
  late int _remainingTime;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _resendAfter = _defaultResendAfter;
    _remainingTime = _resendAfter;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final seconds = _resendSecondsFromState(context.read<AuthViewModel>().state);
      setState(() {
        _resendAfter = seconds;
        _remainingTime = seconds;
      });
      _startTimer();
    });
  }

  int _resendSecondsFromState(AuthState state) {
    final fromRegister = state.registerModel.data?.data?.resendAfter;
    final fromLogin = state.loginModel.data?.data?.resendAfter;
    final seconds = fromRegister ?? fromLogin ?? _defaultResendAfter;
    return seconds > 0 ? seconds : _defaultResendAfter;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          _remainingTime = _resendAfter;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _verifyOtp(BuildContext context) {
    if (_otpCode.length != 6) return;
    final authViewModel = context.read<AuthViewModel>();
    final state = authViewModel.state;
    authViewModel.verifyOtp(
      VerifyOtpRequest(
        phone: state.phone,
        countryCode: state.countryCode,
        code: _otpCode,
        role: state.role,
      ),
    );
  }

  void _onVerified(BuildContext context, AuthState state) {
    final uiRole = AuthRole.toUi(state.role);
    final targetRoute = state.authMode == AuthMode.signup
        ? AppRoutes.completeProfileView
        : AppRoutes.mainLayoutView;
    Navigator.of(context).pop();
    Navigator.of(context).pushNamedAndRemoveUntil(
      targetRoute,
      (route) => false,
      arguments: uiRole,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<AuthViewModel, AuthState>(
      listenWhen: (previous, current) =>
          previous.verifyOtpModel != current.verifyOtpModel,
      listener: (context, state) {
        if (state.verifyOtpModel.isError) {
          CustomToast.error(context, state.verifyOtpModel.errorMessage ?? '');
        }
        if (state.verifyOtpModel.isLoaded) {
          _onVerified(context, state);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(
          top: 16,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text(
                    'auth.otp.title'.tr(),
                    style: theme.bold24.copyWith(
                      fontSize: 20,
                      color: theme.textColor600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF1B365D),
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              BlocBuilder<AuthViewModel, AuthState>(
                builder: (context, state) {
                  final phone = state.phone ?? '';
                  final countryCode = state.countryCode ?? '';
                  return Text(
                    'auth.otp.sentTo'.tr(args: [countryCode, phone]),
                    textAlign: TextAlign.center,
                    style: theme.regular14.copyWith(color: theme.textColor200),
                  );
                },
              ),
              OTPWidget(
                onCompleted: (pin) {
                  setState(() => _otpCode = pin);
                },
                hasError: false,
                isLoading: false,
              ),
              const SizedBox(height: 24),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'auth.otp.resendIn'.tr(
                        args: ['$_remainingTime'],
                      ),
                      style: theme.regular14.copyWith(
                        color: theme.primaryColor300,
                      ),
                    ),
                    TextSpan(
                      text: 'auth.otp.resend'.tr(),
                      style: theme.medium16.copyWith(color: theme.blackColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _verifyOtp(context),
                child: BlocBuilder<AuthViewModel, AuthState>(
                  builder: (context, state) {
                    return state.verifyOtpModel.isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: theme.whiteColor,
                            ),
                          )
                        : Text(
                            'auth.otp.confirm'.tr(),
                            style: theme.regular14.copyWith(
                              color: theme.whiteColor,
                            ),
                          );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
