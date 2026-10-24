import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
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

@LazySingleton(as: PatientRemoteDataSource)
class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final ApiClient apiClient;

  PatientRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientRegisterResponse>> registerPatient(
    PatientRegisterRequest request,
  ) => executeApi(() => apiClient.registerPatient(request));

  @override
  Future<Result<PatientVerifyOtpResponse>> login(PatientLoginRequest request) =>
      executeApi(() => apiClient.loginPatient(request));

  @override
  Future<Result<PatientRegisterResponse>> sendOtp(
    PatientSendOtpRequest request,
  ) => executeApi(() => apiClient.sendPatientOtp(request));

  @override
  Future<Result<PatientRegisterResponse>> forgotPassword(
    PatientSendOtpRequest request,
  ) => executeApi(() => apiClient.forgotPatientPassword(request));

  @override
  Future<Result<PatientVerifyOtpResponse>> verifyOtp(
    PatientVerifyOtpRequest request,
  ) => executeApi(() => apiClient.verifyPatientOtp(request));

  @override
  Future<Result<PatientVerifyResetCodeResponse>> verifyResetCode(
    PatientVerifyResetCodeRequest request,
  ) => executeApi(() => apiClient.verifyPatientResetCode(request));

  @override
  Future<Result<PatientResetPasswordResponse>> resetPassword(
    PatientResetPasswordRequest request,
  ) => executeApi(() => apiClient.resetPatientPassword(request));

  @override
  Future<Result<PatientRegisterDeviceResponse>> registerDevice(
    PatientRegisterDeviceRequest request,
  ) => executeApi(() => apiClient.registerPatientDevice(request));

  @override
  Future<Result<PatientUnregisterDeviceResponse>> unregisterDevice(
    PatientRegisterDeviceRequest request,
  ) => executeApi(() => apiClient.unregisterPatientDevice(request));
}
