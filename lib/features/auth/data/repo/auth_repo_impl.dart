import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/auth/domain/repo/auth_repo.dart';


@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo{
  final RemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<Result<RegisterResponse>> registerPatient(RegisterRequest request)async{
    final response = await remoteDataSource.registerPatient(request);
    switch(response){
      case Success<RegisterResponse>():
        return Success(response.data);
      case Failure<RegisterResponse>():
        return Failure(response.errorMessage);

    }
  }
 }