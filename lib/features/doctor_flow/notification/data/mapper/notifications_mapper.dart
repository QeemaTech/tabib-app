import 'package:tabib_app/features/doctor_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notifications_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/mark_all_read_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/notifications_page_entity.dart';

extension DoctorNotificationsResponseMapper on DoctorNotificationsResponse {
  NotificationsPageEntity toEntity() {
    return NotificationsPageEntity(
      items: data?.map((item) => item.toEntity()).toList() ?? const [],
      page: meta?.page ?? 1,
      limit: meta?.limit ?? 20,
      total: meta?.total ?? 0,
      totalPages: meta?.totalPages ?? 1,
      unreadCount: meta?.unreadCount ?? 0,
    );
  }
}

extension NotificationItemResponseMapper on NotificationItemResponse {
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id ?? '',
      title: titleAr ?? '',
      body: bodyAr ?? '',
      type: type ?? '',
      appointmentId: data?.appointmentId ?? '',
      isRead: isRead ?? false,
      sentAt: sentAt ?? '',
    );
  }
}

extension DoctorNotificationReadResponseMapper on DoctorNotificationReadResponse {
  NotificationEntity toEntity() {
    return data?.toEntity() ??
        const NotificationEntity(
          id: '',
          title: '',
          body: '',
          type: '',
          appointmentId: '',
          isRead: false,
          sentAt: '',
        );
  }
}

extension DoctorMarkAllReadResponseMapper on DoctorMarkAllReadResponse {
  MarkAllReadEntity toEntity() {
    return MarkAllReadEntity(updated: data?.updated ?? 0);
  }
}
