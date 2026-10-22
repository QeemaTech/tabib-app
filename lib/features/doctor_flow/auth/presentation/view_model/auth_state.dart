import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_constants.dart';

class AuthState extends Equatable {
  final BaseState<DoctorRegisterResponse> registerModel;
  final BaseState<DoctorRegisterResponse> loginModel;
  final BaseState<DoctorVerifyOtpResponse> verifyOtpModel;
  final String preferredLanguage;
  final String? countryCode;
  final String? phone;
  final String role;
  final String authMode;

  const AuthState({
    this.registerModel = const BaseState(requestState: RequestState.init),
    this.loginModel = const BaseState(requestState: RequestState.init),
    this.verifyOtpModel = const BaseState(requestState: RequestState.init),
    this.preferredLanguage = 'ar',
    this.countryCode,
    this.phone,
    this.role = AuthRole.patient,
    this.authMode = AuthMode.login,
  });

  AuthState copyWith({
    BaseState<DoctorRegisterResponse>? registerModel,
    BaseState<DoctorRegisterResponse>? loginModel,
    BaseState<DoctorVerifyOtpResponse>? verifyOtpModel,
    String? preferredLanguage,
    String? countryCode,
    String? phone,
    String? role,
    String? authMode,
  }) {
    return AuthState(
      registerModel: registerModel ?? this.registerModel,
      loginModel: loginModel ?? this.loginModel,
      verifyOtpModel: verifyOtpModel ?? this.verifyOtpModel,
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
    verifyOtpModel,
    preferredLanguage,
    countryCode,
    phone,
    role,
    authMode,
  ];
}
