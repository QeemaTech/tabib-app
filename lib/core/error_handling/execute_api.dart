import 'package:easy_localization/easy_localization.dart';
import 'package:tabib_app/core/error_handling/result.dart';

import 'handle_exception.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() callApi) async {
  try {
    final result = await callApi.call();
    return Success(result);
  } catch (e) {
    if (e is Exception) {
      return Failure(NetworkException.getMessageError(e));
    }
    return Failure('errors.unknown'.tr());
  }
}
