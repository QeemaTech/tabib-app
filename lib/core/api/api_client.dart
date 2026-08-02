import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tabib_app/core/api/api_constant.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';
part 'api_client.g.dart';
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

@POST(EndPoint.registerPatient)
Future<RegisterResponse> registerPatient(@Body() RegisterRequest request);

}
