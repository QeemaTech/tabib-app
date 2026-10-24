import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class NetworkError {
  final String message;
  final String? code;

  const NetworkError({required this.message, this.code});
}

class NetworkException {
  NetworkException._();

  static String getMessageError(Exception exception) =>
      describe(exception).message;

  static NetworkError describe(Exception exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
          return NetworkError(message: 'errors.connectionTimeout'.tr());
        case DioExceptionType.sendTimeout:
          return NetworkError(message: 'errors.sendTimeout'.tr());
        case DioExceptionType.receiveTimeout:
          return NetworkError(message: 'errors.receiveTimeout'.tr());
        case DioExceptionType.badCertificate:
          return NetworkError(message: 'errors.badCertificate'.tr());
        case DioExceptionType.badResponse:
          return _handleMessageResponse(exception);
        case DioExceptionType.cancel:
          return NetworkError(message: 'errors.cancel'.tr());
        case DioExceptionType.connectionError:
          return NetworkError(message: 'errors.connectionError'.tr());
        case DioExceptionType.unknown:
          print(exception.message);
          return NetworkError(message: 'errors.unknown'.tr());
        case DioExceptionType.transformTimeout:
          print(exception.message);
          return NetworkError(message: 'errors.unknown'.tr());
      }
    } else {
      log(exception.toString(), name: 'NetworkException');
      return NetworkError(message: 'errors.unknown'.tr());
    }
  }

  static NetworkError _handleMessageResponse(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      final message = _extractErrorMessage(data);
      final code = _extractErrorCode(data);

      switch (statusCode) {
        case 400:
          return NetworkError(
            message: message ?? 'errors.badRequest'.tr(),
            code: code,
          );
        case 401:
          return NetworkError(
            message: message ?? 'errors.error401'.tr(),
            code: code,
          );
        case 403:
          return NetworkError(
            message: message ?? 'errors.error403'.tr(),
            code: code,
          );
        case 404:
          return NetworkError(
            message: message ?? 'errors.notFound'.tr(),
            code: code,
          );
        case 408:
          return NetworkError(message: 'errors.error408'.tr(), code: code);
        case 429:
          return NetworkError(
            message: message ?? 'errors.error429'.tr(),
            code: code,
          );
        case 500:
          return NetworkError(message: 'errors.error500'.tr(), code: code);
        case 502:
          return NetworkError(message: 'errors.error502'.tr(), code: code);
        case 503:
          return NetworkError(message: 'errors.error503'.tr(), code: code);
        case 504:
          return NetworkError(message: 'errors.error504'.tr(), code: code);
        default:
          return NetworkError(
            message:
                message ??
                'errors.serverError'.tr(
                  namedArgs: {'code': '${statusCode ?? 'unknown'}'},
                ),
            code: code,
          );
      }
    }
    return NetworkError(message: 'errors.defaultError'.tr());
  }

  static String? _extractErrorMessage(dynamic data) {
    if (data is! Map) return null;

    final topLevelMessage = data['message']?.toString();
    if (topLevelMessage != null && topLevelMessage.isNotEmpty) {
      return topLevelMessage;
    }

    final error = data['error'];
    if (error is Map) {
      final nestedMessage = error['message']?.toString();
      if (nestedMessage != null && nestedMessage.isNotEmpty) {
        return nestedMessage;
      }
    }

    return null;
  }

  static String? _extractErrorCode(dynamic data) {
    if (data is! Map) return null;
    final error = data['error'];
    if (error is Map) {
      final code = error['code']?.toString();
      if (code != null && code.isNotEmpty) return code;
    }
    return null;
  }

  // static String _handleMessageErrorFromFirebase(FirebaseException exception) {
  //   switch (exception.code) {
  //     case 'permission-denied':
  //       return 'errors.permissionDenied'.tr();
  //     case 'unavailable':
  //       return 'errors.serviceUnavailable'.tr();
  //     case 'deadline-exceeded':
  //       return 'errors.timeout'.tr();
  //     case 'not-found':
  //       return 'errors.notFound'.tr();
  //     case 'already-exists':
  //       return 'errors.alreadyExists'.tr();
  //     case 'unauthenticated':
  //       return 'errors.unauthenticated'.tr();
  //     case 'cancelled':
  //       return 'errors.cancelled'.tr();
  //     case 'resource-exhausted':
  //       return 'errors.resourceExhausted'.tr();
  //     case 'aborted':
  //       return 'errors.aborted'.tr();
  //     case 'internal':
  //       return 'errors.internal'.tr();
  //     default:
  //       return exception.message ?? 'errors.unknown'.tr();
  //   }
  // }
}
