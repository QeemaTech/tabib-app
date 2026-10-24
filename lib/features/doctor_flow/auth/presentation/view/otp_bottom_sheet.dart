import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/send_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_reset_code_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view/reset_password_view.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_state.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_view_model.dart';

import 'otp_widget.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({
    super.key,
    this.purpose = OtpPurpose.accountVerification,
  });

  final OtpPurpose purpose;

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  static const int _defaultResendAfter = 30;

  Timer? _timer;
  late int _resendAfter;
  late int _remainingTime;
  String _otpCode = '';

  bool get _isReset => widget.purpose == OtpPurpose.passwordReset;

  @override
  void initState() {
    super.initState();
    _resendAfter = _defaultResendAfter;
    _remainingTime = _resendAfter;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final seconds = _resendSecondsFromState(
        context.read<DoctorAuthViewModel>().state,
      );
      setState(() {
        _resendAfter = seconds;
        _remainingTime = seconds;
      });
      _startTimer();
    });
  }

  int _resendSecondsFromState(AuthState state) {
    final seconds = _isReset
        ? state.forgotPasswordModel.data?.data?.resendAfter
        : state.sendOtpModel.data?.data?.resendAfter ??
              state.registerModel.data?.data?.resendAfter;
    final value = seconds ?? _defaultResendAfter;
    return value > 0 ? value : _defaultResendAfter;
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
        }
      });
    });
  }

  void _restartTimer(int seconds) {
    setState(() {
      _resendAfter = seconds > 0 ? seconds : _defaultResendAfter;
      _remainingTime = _resendAfter;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _verify(BuildContext context) {
    if (_otpCode.length != 6) return;
    final authViewModel = context.read<DoctorAuthViewModel>();
    final authState = authViewModel.state;
    if (_isReset) {
      authViewModel.verifyResetCode(
        DoctorVerifyResetCodeRequest(
          phone: authState.phone,
          countryCode: authState.countryCode,
          code: _otpCode,
        ),
      );
      return;
    }
    authViewModel.verifyOtp(
      DoctorVerifyOtpRequest(
        phone: authState.phone,
        countryCode: authState.countryCode,
        code: _otpCode,
        role: authState.role,
      ),
    );
  }

  void _resend(BuildContext context) {
    if (_remainingTime > 0) return;
    final authViewModel = context.read<DoctorAuthViewModel>();
    final authState = authViewModel.state;
    final request = DoctorSendOtpRequest(
      phone: authState.phone,
      countryCode: authState.countryCode,
      role: authState.role,
    );
    if (_isReset) {
      authViewModel.forgotPassword(request);
    } else {
      authViewModel.sendOtp(request);
    }
  }

  void _onAccountVerified(BuildContext context, AuthState state) {
    CustomToast.success(context, 'auth.otp.verifiedGoLogin'.tr());
    final navigator = Navigator.of(context);
    final uiRole = AuthRole.toUi(state.role);
    navigator.pop();
    if (state.authMode == AuthMode.signup) {
      navigator.pushNamedAndRemoveUntil(
        AppRoutes.loginView,
        (route) => false,
        arguments: {'mode': AuthMode.login, 'role': uiRole},
      );
    }
  }

  void _onResetVerified(BuildContext context) {
    final navigator = Navigator.of(context);
    final authViewModel = context.read<DoctorAuthViewModel>();
    navigator.pop();
    navigator.push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: authViewModel,
          child: const ResetPasswordView(),
        ),
      ),
    );
  }

  AuthState? _listenedFrom;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<DoctorAuthViewModel, AuthState>(
      listenWhen: (previous, current) {
        _listenedFrom = previous;
        return _isReset
            ? previous.verifyResetCodeModel != current.verifyResetCodeModel ||
                  previous.forgotPasswordModel != current.forgotPasswordModel
            : previous.verifyOtpModel != current.verifyOtpModel ||
                  previous.sendOtpModel != current.sendOtpModel;
      },
      listener: (context, state) {
        final previous = _listenedFrom;
        if (previous == null) return;
        if (_isReset) {
          if (previous.forgotPasswordModel != state.forgotPasswordModel) {
            if (state.forgotPasswordModel.isError) {
              CustomToast.error(
                context,
                state.forgotPasswordModel.errorMessage ?? '',
              );
            }
            if (state.forgotPasswordModel.isLoaded) {
              _restartTimer(_resendSecondsFromState(state));
            }
          }
          if (previous.verifyResetCodeModel != state.verifyResetCodeModel) {
            if (state.verifyResetCodeModel.isError) {
              CustomToast.error(
                context,
                state.verifyResetCodeModel.errorMessage ?? '',
              );
            }
            if (state.verifyResetCodeModel.isLoaded) {
              _onResetVerified(context);
            }
          }
          return;
        }
        if (previous.sendOtpModel != state.sendOtpModel) {
          if (state.sendOtpModel.isError) {
            CustomToast.error(context, state.sendOtpModel.errorMessage ?? '');
          }
          if (state.sendOtpModel.isLoaded) {
            _restartTimer(_resendSecondsFromState(state));
          }
        }
        if (previous.verifyOtpModel != state.verifyOtpModel &&
            state.verifyOtpModel.isError) {
          CustomToast.error(context, state.verifyOtpModel.errorMessage ?? '');
        }
        if (previous.verifyOtpModel != state.verifyOtpModel &&
            state.verifyOtpModel.isLoaded) {
          _onAccountVerified(context, state);
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
              BlocBuilder<DoctorAuthViewModel, AuthState>(
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
              if (_remainingTime > 0)
                Text(
                  'auth.otp.resendIn'.tr(args: ['$_remainingTime']),
                  textAlign: TextAlign.center,
                  style: theme.regular14.copyWith(color: theme.primaryColor300),
                )
              else
                TextButton(
                  onPressed: () => _resend(context),
                  child: Text(
                    'auth.otp.resend'.tr(),
                    style: theme.medium16.copyWith(color: theme.blackColor),
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _verify(context),
                child: BlocBuilder<DoctorAuthViewModel, AuthState>(
                  builder: (context, state) {
                    final isLoading = _isReset
                        ? state.verifyResetCodeModel.isLoading
                        : state.verifyOtpModel.isLoading;
                    return isLoading
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
