import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_constant.dart';
import 'dio_intercepter.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient provideApiClient(Dio dio) {
    return ApiClient(dio, baseUrl: EndPoint.baseUrl);
  }


  @lazySingleton
 Dio provideDio(BaseOptions option, TalkerDioLogger logger) {
    var dio = Dio(option);
    dio.interceptors.add(logger);
    dio.interceptors.add(DioRefreshTokenInterceptor(
    ));
    return dio;
  }

  @lazySingleton
  BaseOptions providerOption() {
    return BaseOptions(
      baseUrl: EndPoint.baseUrl,
      receiveTimeout: const Duration(minutes: 5),
      connectTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 5),
    );
  }

  @lazySingleton
  TalkerDioLogger provideLogger() {
    return TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseMessage: true,
        printErrorMessage: true,
        printRequestData: true,
        printResponseData: true,
        printErrorData: true
      ),
    );
  }
}
