import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/verify_otp_response.dart';

abstract interface class PatientRemoteDataSource {
  Future<Result<PatientRegisterResponse>> registerPatient(PatientRegisterRequest request);

  Future<Result<PatientRegisterResponse>> sendOtp(PatientLoginRequest request);

  Future<Result<PatientVerifyOtpResponse>> verifyOtp(PatientVerifyOtpRequest request);

  Future<Result<PatientRegisterDeviceResponse>> registerDevice(
    PatientRegisterDeviceRequest request,
  );

  Future<Result<PatientUnregisterDeviceResponse>> unregisterDevice(
    PatientRegisterDeviceRequest request,
  );
}
