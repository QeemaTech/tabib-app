import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/verify_otp_response.dart';

@LazySingleton(as: PatientRemoteDataSource)
class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final ApiClient apiClient;

  PatientRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientRegisterResponse>> registerPatient(PatientRegisterRequest request) =>
      executeApi(() => apiClient.registerPatient(request));

  @override
  Future<Result<PatientRegisterResponse>> sendOtp(PatientLoginRequest request) =>
      executeApi(() => apiClient.sendPatientOtp(request));

  @override
  Future<Result<PatientVerifyOtpResponse>> verifyOtp(PatientVerifyOtpRequest request) =>
      executeApi(() => apiClient.verifyPatientOtp(request));

  @override
  Future<Result<PatientRegisterDeviceResponse>> registerDevice(
    PatientRegisterDeviceRequest request,
  ) => executeApi(() => apiClient.registerPatientDevice(request));

  @override
  Future<Result<PatientUnregisterDeviceResponse>> unregisterDevice(
    PatientRegisterDeviceRequest request,
  ) => executeApi(() => apiClient.unregisterPatientDevice(request));
}
