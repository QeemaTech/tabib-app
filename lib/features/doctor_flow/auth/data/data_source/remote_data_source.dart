import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';

abstract interface class DoctorRemoteDataSource {
  Future<Result<DoctorRegisterResponse>> registerDoctor(DoctorRegisterRequest request);

  Future<Result<DoctorRegisterResponse>> sendOtp(DoctorLoginRequest request);

  Future<Result<DoctorVerifyOtpResponse>> verifyOtp(DoctorVerifyOtpRequest request);

  Future<Result<DoctorRegisterDeviceResponse>> registerDevice(
    DoctorRegisterDeviceRequest request,
  );

  Future<Result<DoctorUnregisterDeviceResponse>> unregisterDevice(
    DoctorRegisterDeviceRequest request,
  );
}
