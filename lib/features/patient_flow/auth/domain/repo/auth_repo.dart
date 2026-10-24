import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/login_request.dart';
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

abstract interface class PatientAuthRepo {
  Future<Result<PatientRegisterResponse>> registerPatient(
    PatientRegisterRequest request,
  );

  Future<Result<PatientVerifyOtpResponse>> login(PatientLoginRequest request);

  Future<Result<PatientRegisterResponse>> sendOtp(
    PatientSendOtpRequest request,
  );

  Future<Result<PatientRegisterResponse>> forgotPassword(
    PatientSendOtpRequest request,
  );

  Future<Result<PatientVerifyOtpResponse>> verifyOtp(
    PatientVerifyOtpRequest request,
  );

  Future<Result<PatientVerifyResetCodeResponse>> verifyResetCode(
    PatientVerifyResetCodeRequest request,
  );

  Future<Result<PatientResetPasswordResponse>> resetPassword(
    PatientResetPasswordRequest request,
  );

  Future<Result<PatientRegisterDeviceResponse>> registerDevice();

  Future<Result<PatientUnregisterDeviceResponse>> unregisterDevice();
}
