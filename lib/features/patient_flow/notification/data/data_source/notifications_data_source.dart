import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notifications_response.dart';

abstract interface class PatientNotificationsDataSource {
  Future<Result<PatientNotificationsResponse>> getNotifications({
    required int page,
    required int limit,
    bool? isRead,
  });

  Future<Result<PatientNotificationReadResponse>> markAsRead(String id);

  Future<Result<PatientMarkAllReadResponse>> markAllAsRead();
}
