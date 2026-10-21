import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class NetworkException {
  NetworkException._();

  static String getMessageError(Exception exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
          return 'errors.connectionTimeout'.tr();
        case DioExceptionType.sendTimeout:
          return 'errors.sendTimeout'.tr();
        case DioExceptionType.receiveTimeout:
          return 'errors.receiveTimeout'.tr();
        case DioExceptionType.badCertificate:
          return 'errors.badCertificate'.tr();
        case DioExceptionType.badResponse:
          return _handleMessageResponse(exception);
        case DioExceptionType.cancel:
          return 'errors.cancel'.tr();
        case DioExceptionType.connectionError:
          return 'errors.connectionError'.tr();
        case DioExceptionType.unknown:
          print(exception.message);
          return 'errors.unknown'.tr();
        case DioExceptionType.transformTimeout:
          print(exception.message);
          return 'errors.unknown'.tr();
      }
    }
    else {
      log(exception.toString(), name: 'NetworkException');
      return 'errors.unknown'.tr();
    }
  }

  static String _handleMessageResponse(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      final message = _extractErrorMessage(data);

      switch (statusCode) {
        case 400:
          return message ?? 'errors.badRequest'.tr();
        case 401:
          return message ?? 'errors.error401'.tr();
        case 403:
          return 'errors.error403'.tr();
        case 404:
          return message ?? 'errors.notFound'.tr();
        case 408:
          return 'errors.error408'.tr();
        case 429:
          return message??'errors.error429'.tr();
        case 500:
          return 'errors.error500'.tr();
        case 502:
          return 'errors.error502'.tr();
        case 503:
          return 'errors.error503'.tr();
        case 504:
          return 'errors.error504'.tr();
        default:
          return message ??
              'errors.serverError'.tr(
                namedArgs: {'code': '${statusCode ?? 'unknown'}'},
              );
      }
    }
    return 'errors.defaultError'.tr();
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
