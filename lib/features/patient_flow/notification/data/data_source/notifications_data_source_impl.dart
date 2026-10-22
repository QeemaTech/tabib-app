import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/notification/data/data_source/notifications_data_source.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notifications_response.dart';

@LazySingleton(as: PatientNotificationsDataSource)
class PatientNotificationsDataSourceImpl
    implements PatientNotificationsDataSource {
  final ApiClient apiClient;

  PatientNotificationsDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientNotificationsResponse>> getNotifications({
    required int page,
    required int limit,
    bool? isRead,
  }) {
    return executeApi(
      () => apiClient.getPatientNotifications(
        page: page,
        limit: limit,
        isRead: isRead,
      ),
    );
  }

  @override
  Future<Result<PatientNotificationReadResponse>> markAsRead(String id) {
    return executeApi(() => apiClient.markPatientNotificationRead(id));
  }

  @override
  Future<Result<PatientMarkAllReadResponse>> markAllAsRead() {
    return executeApi(() => apiClient.markAllPatientNotificationsRead());
  }
}
