import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/core/services/fcm_service.dart';
import 'package:tabib_app/features/patient_flow/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/repo/auth_repo.dart';

@LazySingleton(as: PatientAuthRepo)
class PatientAuthRepoImpl implements PatientAuthRepo {
  final PatientRemoteDataSource remoteDataSource;

  PatientAuthRepoImpl(this.remoteDataSource);

  @override
  Future<Result<PatientRegisterResponse>> registerPatient(
    PatientRegisterRequest request,
  ) async {
    final response = await remoteDataSource.registerPatient(request);
    switch (response) {
      case Success<PatientRegisterResponse>():
        return Success(response.data);
      case Failure<PatientRegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientRegisterResponse>> sendOtp(PatientLoginRequest request) async {
    final response = await remoteDataSource.sendOtp(request);
    switch (response) {
      case Success<PatientRegisterResponse>():
        return Success(response.data);
      case Failure<PatientRegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientVerifyOtpResponse>> verifyOtp(PatientVerifyOtpRequest request) async {
    final response = await remoteDataSource.verifyOtp(request);

    switch (response) {
      case Success<PatientVerifyOtpResponse>():
        _saveToken(
          response.data.data?.accessToken ?? '',
          response.data.data?.refreshToken ?? '',
        );
        SocketIoService(token: response.data.data?.accessToken ?? ''  ).connect();
        return Success(response.data);
      case Failure<PatientVerifyOtpResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientRegisterDeviceResponse>> registerDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(PatientRegisterDeviceResponse(success: true));
    }
    final response = await remoteDataSource.registerDevice(request);
    switch (response) {
      case Success<PatientRegisterDeviceResponse>():
        return Success(response.data);
      case Failure<PatientRegisterDeviceResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientUnregisterDeviceResponse>> unregisterDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(PatientUnregisterDeviceResponse(success: true));
    }
    final response = await remoteDataSource.unregisterDevice(request);
    switch (response) {
      case Success<PatientUnregisterDeviceResponse>():
        return Success(response.data);
      case Failure<PatientUnregisterDeviceResponse>():
        return Failure(response.errorMessage);
    }
  }

  Future<PatientRegisterDeviceRequest?> _deviceRequest() async {
    final fcmToken =
        await FcmService.cachedToken() ?? await FcmService.currentToken();
    if (fcmToken == null || fcmToken.isEmpty) {
      return null;
    }
    return PatientRegisterDeviceRequest(
      fcmToken: fcmToken,
      platform: FcmService.platform.toUpperCase(),
      deviceName: '',
    );
  }

  void _saveToken(String token, String refreshToken) async {
    await AppLocalStorage.setSecuredString(key: LocalKeys.token, value: token);
    await AppLocalStorage.setSecuredString(
      key: LocalKeys.refreshToken,
      value: refreshToken,
    );
  }
}
