import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';

abstract interface class AuthRepo {
  Future<Result<RegisterResponse>> registerPatient(RegisterRequest request);
}