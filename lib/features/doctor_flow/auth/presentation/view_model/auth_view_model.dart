import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/core/services/fcm_service.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/reset_password_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/send_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_reset_code_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/reset_password_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_reset_code_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/repo/auth_repo.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/view_model/auth_state.dart';

@injectable
class DoctorAuthViewModel extends Cubit<AuthState> {
  final DoctorAuthRepo authRepo;

  DoctorAuthViewModel({required this.authRepo}) : super(const AuthState());

  void setPreferredLanguage(String value) {
    emit(state.copyWith(preferredLanguage: value));
  }

  void setCountryCode(String countryCode) {
    emit(state.copyWith(countryCode: countryCode));
  }

  void setPhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void setRole(String uiRole) {
    emit(state.copyWith(role: AuthRole.fromUi(uiRole)));
  }

  void setAuthMode(String authMode) {
    emit(state.copyWith(authMode: authMode));
  }

  void setOpenVerificationSheet(bool value) {
    emit(state.copyWith(openVerificationSheet: value));
  }

  void setOpenResetSheet(bool value) {
    emit(state.copyWith(openResetSheet: value));
  }

  Future<void> register(DoctorRegisterRequest request) async {
    emit(
      state.copyWith(
        registerModel: BaseState.loading(),
        phone: request.phone,
        countryCode: request.countryCode ?? state.countryCode,
      ),
    );
    final result = await authRepo.registerDoctor(request);
    switch (result) {
      case Success<DoctorRegisterResponse>():
        emit(state.copyWith(registerModel: BaseState.loaded(result.data)));
      case Failure<DoctorRegisterResponse>():
        emit(
          state.copyWith(registerModel: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> login(DoctorLoginRequest request) async {
    emit(
      state.copyWith(
        loginModel: BaseState.loading(),
        phone: request.phone,
        countryCode: request.countryCode ?? state.countryCode,
        openVerificationSheet: false,
      ),
    );
    final result = await authRepo.login(request);
    switch (result) {
      case Success<DoctorVerifyOtpResponse>():
        await _persistSession(result.data);
      case Failure<DoctorVerifyOtpResponse>():
        emit(state.copyWith(loginModel: BaseState.error(result.errorMessage)));
        if (result.errorCode == AuthErrorCode.unverified) {
          await sendOtp(
            DoctorSendOtpRequest(
              phone: request.phone,
              countryCode: request.countryCode,
              role: request.role,
            ),
            openSheet: true,
          );
        }
    }
  }

  Future<void> sendOtp(
    DoctorSendOtpRequest request, {
    bool openSheet = false,
  }) async {
    emit(
      state.copyWith(
        sendOtpModel: BaseState.loading(),
        phone: request.phone,
        countryCode: request.countryCode ?? state.countryCode,
        openVerificationSheet: openSheet,
      ),
    );
    final result = await authRepo.sendOtp(request);
    switch (result) {
      case Success<DoctorRegisterResponse>():
        emit(state.copyWith(sendOtpModel: BaseState.loaded(result.data)));
      case Failure<DoctorRegisterResponse>():
        emit(
          state.copyWith(sendOtpModel: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> forgotPassword(
    DoctorSendOtpRequest request, {
    bool openSheet = false,
  }) async {
    emit(
      state.copyWith(
        forgotPasswordModel: BaseState.loading(),
        phone: request.phone,
        countryCode: request.countryCode ?? state.countryCode,
        openResetSheet: openSheet,
      ),
    );
    final result = await authRepo.forgotPassword(request);
    switch (result) {
      case Success<DoctorRegisterResponse>():
        emit(
          state.copyWith(forgotPasswordModel: BaseState.loaded(result.data)),
        );
      case Failure<DoctorRegisterResponse>():
        emit(
          state.copyWith(
            forgotPasswordModel: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> verifyOtp(DoctorVerifyOtpRequest request) async {
    emit(state.copyWith(verifyOtpModel: BaseState.loading()));
    final result = await authRepo.verifyOtp(request);
    switch (result) {
      case Success<DoctorVerifyOtpResponse>():
        emit(state.copyWith(verifyOtpModel: BaseState.loaded(result.data)));
      case Failure<DoctorVerifyOtpResponse>():
        emit(
          state.copyWith(verifyOtpModel: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> verifyResetCode(DoctorVerifyResetCodeRequest request) async {
    emit(
      state.copyWith(
        verifyResetCodeModel: BaseState.loading(),
        resetCode: request.code,
      ),
    );
    final result = await authRepo.verifyResetCode(request);
    switch (result) {
      case Success<DoctorVerifyResetCodeResponse>():
        emit(
          state.copyWith(
            verifyResetCodeModel: BaseState.loaded(result.data),
            resetToken: result.data.data?.resetToken,
          ),
        );
      case Failure<DoctorVerifyResetCodeResponse>():
        emit(
          state.copyWith(
            verifyResetCodeModel: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> resetPassword(DoctorResetPasswordRequest request) async {
    emit(state.copyWith(resetPasswordModel: BaseState.loading()));
    final result = await authRepo.resetPassword(request);
    switch (result) {
      case Success<DoctorResetPasswordResponse>():
        emit(state.copyWith(resetPasswordModel: BaseState.loaded(result.data)));
      case Failure<DoctorResetPasswordResponse>():
        emit(
          state.copyWith(
            resetPasswordModel: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> _persistSession(DoctorVerifyOtpResponse response) async {
    final accessToken = response.data?.accessToken;
    final refreshToken = response.data?.refreshToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      await AppLocalStorage.setSecuredString(
        key: LocalKeys.token,
        value: accessToken,
      );
      SocketIoService(token: accessToken).connect();
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await AppLocalStorage.setSecuredString(
        key: LocalKeys.refreshToken,
        value: refreshToken,
      );
    }

    final apiRole = response.data?.user?.role;
    final resolvedApiRole = (apiRole != null && apiRole.isNotEmpty)
        ? apiRole
        : state.role;
    final uiRole = AuthRole.toUi(resolvedApiRole);
    CachedUserRole.uiRole = uiRole;
    await AppLocalStorage.setSecuredString(key: LocalKeys.role, value: uiRole);

    await FcmService.requestNotificationPermission();
    await authRepo.registerDevice();

    emit(
      state.copyWith(
        loginModel: BaseState.loaded(response),
        role: resolvedApiRole,
      ),
    );
  }
}
