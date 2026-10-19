import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/auth/data/models/response/verify_otp_response.dart';

abstract interface class AuthRepo {
  Future<Result<RegisterResponse>> registerPatient(RegisterRequest request);

  Future<Result<RegisterResponse>> registerDoctor(RegisterRequest request);

  Future<Result<RegisterResponse>> sendOtp(LoginRequest request);

  Future<Result<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest request);

  Future<Result<RegisterDeviceResponse>> registerDevice();

  Future<Result<UnregisterDeviceResponse>> unregisterDevice();
}
