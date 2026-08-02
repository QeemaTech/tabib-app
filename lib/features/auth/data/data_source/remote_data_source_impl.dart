import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';


@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource{
  final ApiClient apiClient;

  RemoteDataSourceImpl(this.apiClient);
  @override
  Future<Result<RegisterResponse>> registerPatient(RegisterRequest request) =>executeApi(()=>apiClient.registerPatient(request));
}