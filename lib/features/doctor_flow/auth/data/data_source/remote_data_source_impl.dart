import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';

@LazySingleton(as: DoctorRemoteDataSource)
class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final ApiClient apiClient;

  DoctorRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorRegisterResponse>> registerDoctor(DoctorRegisterRequest request) =>
      executeApi(() => apiClient.registerDoctor(request));

  @override
  Future<Result<DoctorRegisterResponse>> sendOtp(DoctorLoginRequest request) =>
      executeApi(() => apiClient.sendDoctorOtp(request));

  @override
  Future<Result<DoctorVerifyOtpResponse>> verifyOtp(DoctorVerifyOtpRequest request) =>
      executeApi(() => apiClient.verifyDoctorOtp(request));

  @override
  Future<Result<DoctorRegisterDeviceResponse>> registerDevice(
    DoctorRegisterDeviceRequest request,
  ) => executeApi(() => apiClient.registerDoctorDevice(request));

  @override
  Future<Result<DoctorUnregisterDeviceResponse>> unregisterDevice(
    DoctorRegisterDeviceRequest request,
  ) => executeApi(() => apiClient.unregisterDoctorDevice(request));
}
