import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';




class DioRefreshTokenInterceptor extends Interceptor {
  DioRefreshTokenInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken =
        await AppLocalStorage.getSecuredString(key: LocalKeys.token);
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }
}

