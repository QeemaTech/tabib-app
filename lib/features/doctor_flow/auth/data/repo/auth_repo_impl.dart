import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/core/services/fcm_service.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/repo/auth_repo.dart';

@LazySingleton(as: DoctorAuthRepo)
class DoctorAuthRepoImpl implements DoctorAuthRepo {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorAuthRepoImpl(this.remoteDataSource);

  @override
  Future<Result<DoctorRegisterResponse>> registerDoctor(
    DoctorRegisterRequest request,
  ) async {
    final response = await remoteDataSource.registerDoctor(request);
    switch (response) {
      case Success<DoctorRegisterResponse>():
        return Success(response.data);
      case Failure<DoctorRegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorRegisterResponse>> sendOtp(DoctorLoginRequest request) async {
    final response = await remoteDataSource.sendOtp(request);
    switch (response) {
      case Success<DoctorRegisterResponse>():
        return Success(response.data);
      case Failure<DoctorRegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorVerifyOtpResponse>> verifyOtp(DoctorVerifyOtpRequest request) async {
    final response = await remoteDataSource.verifyOtp(request);

    switch (response) {
      case Success<DoctorVerifyOtpResponse>():
        _saveToken(
          response.data.data?.accessToken ?? '',
          response.data.data?.refreshToken ?? '',
        );
        SocketIoService(token: response.data.data?.accessToken ?? ''  ).connect();
        return Success(response.data);
      case Failure<DoctorVerifyOtpResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorRegisterDeviceResponse>> registerDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(DoctorRegisterDeviceResponse(success: true));
    }
    final response = await remoteDataSource.registerDevice(request);
    switch (response) {
      case Success<DoctorRegisterDeviceResponse>():
        return Success(response.data);
      case Failure<DoctorRegisterDeviceResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorUnregisterDeviceResponse>> unregisterDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(DoctorUnregisterDeviceResponse(success: true));
    }
    final response = await remoteDataSource.unregisterDevice(request);
    switch (response) {
      case Success<DoctorUnregisterDeviceResponse>():
        return Success(response.data);
      case Failure<DoctorUnregisterDeviceResponse>():
        return Failure(response.errorMessage);
    }
  }

  Future<DoctorRegisterDeviceRequest?> _deviceRequest() async {
    final fcmToken =
        await FcmService.cachedToken() ?? await FcmService.currentToken();
    if (fcmToken == null || fcmToken.isEmpty) {
      return null;
    }
    return DoctorRegisterDeviceRequest(
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
