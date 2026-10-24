import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/reset_password_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_reset_code_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_constants.dart';

class AuthState extends Equatable {
  final BaseState<DoctorRegisterResponse> registerModel;
  final BaseState<DoctorVerifyOtpResponse> loginModel;
  final BaseState<DoctorRegisterResponse> sendOtpModel;
  final BaseState<DoctorRegisterResponse> forgotPasswordModel;
  final BaseState<DoctorVerifyOtpResponse> verifyOtpModel;
  final BaseState<DoctorVerifyResetCodeResponse> verifyResetCodeModel;
  final BaseState<DoctorResetPasswordResponse> resetPasswordModel;
  final bool openVerificationSheet;
  final bool openResetSheet;
  final String? resetToken;
  final String? resetCode;
  final String preferredLanguage;
  final String? countryCode;
  final String? phone;
  final String role;
  final String authMode;

  const AuthState({
    this.registerModel = const BaseState(requestState: RequestState.init),
    this.loginModel = const BaseState(requestState: RequestState.init),
    this.sendOtpModel = const BaseState(requestState: RequestState.init),
    this.forgotPasswordModel = const BaseState(requestState: RequestState.init),
    this.verifyOtpModel = const BaseState(requestState: RequestState.init),
    this.verifyResetCodeModel = const BaseState(
      requestState: RequestState.init,
    ),
    this.resetPasswordModel = const BaseState(requestState: RequestState.init),
    this.openVerificationSheet = false,
    this.openResetSheet = false,
    this.resetToken,
    this.resetCode,
    this.preferredLanguage = 'ar',
    this.countryCode,
    this.phone,
    this.role = AuthRole.doctor,
    this.authMode = AuthMode.login,
  });

  AuthState copyWith({
    BaseState<DoctorRegisterResponse>? registerModel,
    BaseState<DoctorVerifyOtpResponse>? loginModel,
    BaseState<DoctorRegisterResponse>? sendOtpModel,
    BaseState<DoctorRegisterResponse>? forgotPasswordModel,
    BaseState<DoctorVerifyOtpResponse>? verifyOtpModel,
    BaseState<DoctorVerifyResetCodeResponse>? verifyResetCodeModel,
    BaseState<DoctorResetPasswordResponse>? resetPasswordModel,
    bool? openVerificationSheet,
    bool? openResetSheet,
    String? resetToken,
    String? resetCode,
    String? preferredLanguage,
    String? countryCode,
    String? phone,
    String? role,
    String? authMode,
  }) {
    return AuthState(
      registerModel: registerModel ?? this.registerModel,
      loginModel: loginModel ?? this.loginModel,
      sendOtpModel: sendOtpModel ?? this.sendOtpModel,
      forgotPasswordModel: forgotPasswordModel ?? this.forgotPasswordModel,
      verifyOtpModel: verifyOtpModel ?? this.verifyOtpModel,
      verifyResetCodeModel: verifyResetCodeModel ?? this.verifyResetCodeModel,
      resetPasswordModel: resetPasswordModel ?? this.resetPasswordModel,
      openVerificationSheet:
          openVerificationSheet ?? this.openVerificationSheet,
      openResetSheet: openResetSheet ?? this.openResetSheet,
      resetToken: resetToken ?? this.resetToken,
      resetCode: resetCode ?? this.resetCode,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      countryCode: countryCode ?? this.countryCode,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      authMode: authMode ?? this.authMode,
    );
  }

  @override
  List<Object?> get props => [
    registerModel,
    loginModel,
    sendOtpModel,
    forgotPasswordModel,
    verifyOtpModel,
    verifyResetCodeModel,
    resetPasswordModel,
    openVerificationSheet,
    openResetSheet,
    resetToken,
    resetCode,
    preferredLanguage,
    countryCode,
    phone,
    role,
    authMode,
  ];
}
