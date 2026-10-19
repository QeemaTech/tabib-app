import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/core/services/fcm_service.dart';
import 'package:tabib_app/features/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/auth/domain/repo/auth_repo.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_constants.dart';
import 'package:tabib_app/features/auth/presentation/view_model/auth_state.dart';

@injectable
class AuthViewModel extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthViewModel(this.authRepo) : super(const AuthState());

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

  Future<void> register(RegisterRequest request) async {
    final isDoctor = state.role == AuthRole.doctor;
    emit(
      state.copyWith(
        registerModel: BaseState.loading(),
        phone: request.phone,
        countryCode: request.countryCode ?? state.countryCode,
      ),
    );
    final result = isDoctor
        ? await authRepo.registerDoctor(request)
        : await authRepo.registerPatient(request);
    switch (result) {
      case Success<RegisterResponse>():
        emit(state.copyWith(registerModel: BaseState.loaded(result.data)));
      case Failure<RegisterResponse>():
        emit(
          state.copyWith(registerModel: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> sendOtp(LoginRequest request) async {
    emit(
      state.copyWith(
        loginModel: BaseState.loading(),
        phone: request.phone,
        countryCode: request.countryCode ?? state.countryCode,
      ),
    );
    final result = await authRepo.sendOtp(request);
    switch (result) {
      case Success<RegisterResponse>():
        emit(state.copyWith(loginModel: BaseState.loaded(result.data)));
      case Failure<RegisterResponse>():
        emit(state.copyWith(loginModel: BaseState.error(result.errorMessage)));
    }
  }

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    emit(state.copyWith(verifyOtpModel: BaseState.loading()));
    final result = await authRepo.verifyOtp(request);
    switch (result) {
      case Success<VerifyOtpResponse>():
        final accessToken = result.data.data?.accessToken;
        final refreshToken = result.data.data?.refreshToken;
        if (accessToken != null && accessToken.isNotEmpty) {
          await AppLocalStorage.setSecuredString(
            key: LocalKeys.token,
            value: accessToken,
          );
        }
        if (refreshToken != null && refreshToken.isNotEmpty) {
          await AppLocalStorage.setSecuredString(
            key: LocalKeys.refreshToken,
            value: refreshToken,
          );
        }

        final apiRole = result.data.data?.user?.role;
        final resolvedApiRole =
            (apiRole != null && apiRole.isNotEmpty) ? apiRole : state.role;
        final uiRole = AuthRole.toUi(resolvedApiRole);
        CachedUserRole.uiRole = uiRole;
        await AppLocalStorage.setSecuredString(
          key: LocalKeys.role,
          value: uiRole,
        );

        await FcmService.requestNotificationPermission();
        await authRepo.registerDevice();

        emit(
          state.copyWith(
            verifyOtpModel: BaseState.loaded(result.data),
            role: resolvedApiRole,
          ),
        );
      case Failure<VerifyOtpResponse>():
        emit(
          state.copyWith(verifyOtpModel: BaseState.error(result.errorMessage)),
        );
    }
  }
}
