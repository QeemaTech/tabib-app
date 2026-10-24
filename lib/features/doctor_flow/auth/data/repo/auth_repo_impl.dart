import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/core/services/fcm_service.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/reset_password_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/send_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_reset_code_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/reset_password_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_reset_code_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/repo/auth_repo.dart';

@LazySingleton(as: DoctorAuthRepo)
class DoctorAuthRepoImpl implements DoctorAuthRepo {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorAuthRepoImpl(this.remoteDataSource);

  @override
  Future<Result<DoctorRegisterResponse>> registerDoctor(
    DoctorRegisterRequest request,
  ) => remoteDataSource.registerDoctor(request);

  @override
  Future<Result<DoctorVerifyOtpResponse>> login(DoctorLoginRequest request) =>
      remoteDataSource.login(request);

  @override
  Future<Result<DoctorRegisterResponse>> sendOtp(
    DoctorSendOtpRequest request,
  ) => remoteDataSource.sendOtp(request);

  @override
  Future<Result<DoctorRegisterResponse>> forgotPassword(
    DoctorSendOtpRequest request,
  ) => remoteDataSource.forgotPassword(request);

  @override
  Future<Result<DoctorVerifyOtpResponse>> verifyOtp(
    DoctorVerifyOtpRequest request,
  ) => remoteDataSource.verifyOtp(request);

  @override
  Future<Result<DoctorVerifyResetCodeResponse>> verifyResetCode(
    DoctorVerifyResetCodeRequest request,
  ) => remoteDataSource.verifyResetCode(request);

  @override
  Future<Result<DoctorResetPasswordResponse>> resetPassword(
    DoctorResetPasswordRequest request,
  ) => remoteDataSource.resetPassword(request);

  @override
  Future<Result<DoctorRegisterDeviceResponse>> registerDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(DoctorRegisterDeviceResponse(success: true));
    }
    return remoteDataSource.registerDevice(request);
  }

  @override
  Future<Result<DoctorUnregisterDeviceResponse>> unregisterDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(DoctorUnregisterDeviceResponse(success: true));
    }
    return remoteDataSource.unregisterDevice(request);
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
}
