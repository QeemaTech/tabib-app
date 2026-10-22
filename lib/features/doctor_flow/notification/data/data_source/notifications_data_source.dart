import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notifications_response.dart';

abstract interface class DoctorNotificationsDataSource {
  Future<Result<DoctorNotificationsResponse>> getNotifications({
    required int page,
    required int limit,
    bool? isRead,
  });

  Future<Result<DoctorNotificationReadResponse>> markAsRead(String id);

  Future<Result<DoctorMarkAllReadResponse>> markAllAsRead();
}
