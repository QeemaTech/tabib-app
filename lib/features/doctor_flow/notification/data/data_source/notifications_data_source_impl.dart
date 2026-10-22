import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/data_source/notifications_data_source.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notifications_response.dart';

@LazySingleton(as: DoctorNotificationsDataSource)
class DoctorNotificationsDataSourceImpl implements DoctorNotificationsDataSource {
  final ApiClient apiClient;

  DoctorNotificationsDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorNotificationsResponse>> getNotifications({
    required int page,
    required int limit,
    bool? isRead,
  }) {
    return executeApi(
      () => apiClient.getDoctorNotifications(
        page: page,
        limit: limit,
        isRead: isRead,
      ),
    );
  }

  @override
  Future<Result<DoctorNotificationReadResponse>> markAsRead(String id) {
    return executeApi(() => apiClient.markDoctorNotificationRead(id));
  }

  @override
  Future<Result<DoctorMarkAllReadResponse>> markAllAsRead() {
    return executeApi(() => apiClient.markAllDoctorNotificationsRead());
  }
}
