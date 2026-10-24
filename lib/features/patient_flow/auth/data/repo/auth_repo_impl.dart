import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/core/services/fcm_service.dart';
import 'package:tabib_app/features/patient_flow/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/reset_password_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/send_otp_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/verify_reset_code_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/reset_password_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/verify_reset_code_response.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/repo/auth_repo.dart';

@LazySingleton(as: PatientAuthRepo)
class PatientAuthRepoImpl implements PatientAuthRepo {
  final PatientRemoteDataSource remoteDataSource;

  PatientAuthRepoImpl(this.remoteDataSource);

  @override
  Future<Result<PatientRegisterResponse>> registerPatient(
    PatientRegisterRequest request,
  ) => remoteDataSource.registerPatient(request);

  @override
  Future<Result<PatientVerifyOtpResponse>> login(PatientLoginRequest request) =>
      remoteDataSource.login(request);

  @override
  Future<Result<PatientRegisterResponse>> sendOtp(
    PatientSendOtpRequest request,
  ) => remoteDataSource.sendOtp(request);

  @override
  Future<Result<PatientRegisterResponse>> forgotPassword(
    PatientSendOtpRequest request,
  ) => remoteDataSource.forgotPassword(request);

  @override
  Future<Result<PatientVerifyOtpResponse>> verifyOtp(
    PatientVerifyOtpRequest request,
  ) => remoteDataSource.verifyOtp(request);

  @override
  Future<Result<PatientVerifyResetCodeResponse>> verifyResetCode(
    PatientVerifyResetCodeRequest request,
  ) => remoteDataSource.verifyResetCode(request);

  @override
  Future<Result<PatientResetPasswordResponse>> resetPassword(
    PatientResetPasswordRequest request,
  ) => remoteDataSource.resetPassword(request);

  @override
  Future<Result<PatientRegisterDeviceResponse>> registerDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(PatientRegisterDeviceResponse(success: true));
    }
    return remoteDataSource.registerDevice(request);
  }

  @override
  Future<Result<PatientUnregisterDeviceResponse>> unregisterDevice() async {
    final request = await _deviceRequest();
    if (request == null) {
      return Success(PatientUnregisterDeviceResponse(success: true));
    }
    return remoteDataSource.unregisterDevice(request);
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
}
