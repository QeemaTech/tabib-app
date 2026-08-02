 import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';

import '../../../../core/error_handling/result.dart';

abstract interface class RemoteDataSource {
  Future<Result<RegisterResponse>> registerPatient(RegisterRequest request);
 }