import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/notification/data/data_source/notifications_data_source.dart';
import 'package:tabib_app/features/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/notification/data/models/response/notifications_response.dart';

@LazySingleton(as: NotificationsDataSource)
class NotificationsDataSourceImpl implements NotificationsDataSource {
  final ApiClient apiClient;

  NotificationsDataSourceImpl(this.apiClient);

  bool get _isDoctor {
    final role = CachedUserRole.uiRole;
    return role == 'doctor' || role == 'doc';
  }

  @override
  Future<Result<NotificationsResponse>> getNotifications({
    required int page,
    required int limit,
    bool? isRead,
  }) {
    return executeApi(
      () => _isDoctor
          ? apiClient.getDoctorNotifications(
              page: page,
              limit: limit,
              isRead: isRead,
            )
          : apiClient.getPatientNotifications(
              page: page,
              limit: limit,
              isRead: isRead,
            ),
    );
  }

  @override
  Future<Result<NotificationReadResponse>> markAsRead(String id) {
    return executeApi(
      () => _isDoctor
          ? apiClient.markDoctorNotificationRead(id)
          : apiClient.markPatientNotificationRead(id),
    );
  }

  @override
  Future<Result<MarkAllReadResponse>> markAllAsRead() {
    return executeApi(
      () => _isDoctor
          ? apiClient.markAllDoctorNotificationsRead()
          : apiClient.markAllPatientNotificationsRead(),
    );
  }
}
