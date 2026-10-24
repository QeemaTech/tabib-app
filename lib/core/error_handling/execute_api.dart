import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:tabib_app/core/error_handling/result.dart';

import 'handle_exception.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() callApi) async {
  try {
    final result = await callApi.call();
    return Success(result);
  } catch (e) {
    if (e is Exception) {
      final error = NetworkException.describe(e);
      return Failure(error.message, errorCode: error.code);
    }
    log(e.toString(), name: 'executeApi');
    return Failure('errors.unknown'.tr());
  }
}
