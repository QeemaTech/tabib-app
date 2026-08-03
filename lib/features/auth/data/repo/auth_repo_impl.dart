import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/auth/domain/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final RemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<Result<RegisterResponse>> registerPatient(
    RegisterRequest request,
  ) async {
    final response = await remoteDataSource.registerPatient(request);
    switch (response) {
      case Success<RegisterResponse>():
        return Success(response.data);
      case Failure<RegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<RegisterResponse>> registerDoctor(
    RegisterRequest request,
  ) async {
    final response = await remoteDataSource.registerDoctor(request);
    switch (response) {
      case Success<RegisterResponse>():
        return Success(response.data);
      case Failure<RegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<RegisterResponse>> sendOtp(LoginRequest request) async {
    final response = await remoteDataSource.sendOtp(request);
    switch (response) {
      case Success<RegisterResponse>():
        return Success(response.data);
      case Failure<RegisterResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest request) async {
    final response = await remoteDataSource.verifyOtp(request);
    switch (response) {
      case Success<VerifyOtpResponse>():
        return Success(response.data);
      case Failure<VerifyOtpResponse>():
        return Failure(response.errorMessage);
    }
  }
}
