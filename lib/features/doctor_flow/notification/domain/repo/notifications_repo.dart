import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/mark_all_read_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/notifications_page_entity.dart';

abstract interface class DoctorNotificationsRepo {
  Future<Result<NotificationsPageEntity>> getNotifications({
    required int page,
    required int limit,
    bool? isRead,
  });

  Future<Result<NotificationEntity>> markAsRead(String id);

  Future<Result<MarkAllReadEntity>> markAllAsRead();
}
