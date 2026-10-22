import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/notification/data/data_source/notifications_data_source.dart';
import 'package:tabib_app/features/patient_flow/notification/data/mapper/notifications_mapper.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notifications_response.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/entities/mark_all_read_entity.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/entities/notifications_page_entity.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/repo/notifications_repo.dart';

@LazySingleton(as: PatientNotificationsRepo)
class PatientNotificationsRepoImpl implements PatientNotificationsRepo {
  final PatientNotificationsDataSource dataSource;

  PatientNotificationsRepoImpl(this.dataSource);

  @override
  Future<Result<NotificationsPageEntity>> getNotifications({
    required int page,
    required int limit,
    bool? isRead,
  }) async {
    final response = await dataSource.getNotifications(
      page: page,
      limit: limit,
      isRead: isRead,
    );
    switch (response) {
      case Success<PatientNotificationsResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientNotificationsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<NotificationEntity>> markAsRead(String id) async {
    final response = await dataSource.markAsRead(id);
    switch (response) {
      case Success<PatientNotificationReadResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientNotificationReadResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<MarkAllReadEntity>> markAllAsRead() async {
    final response = await dataSource.markAllAsRead();
    switch (response) {
      case Success<PatientMarkAllReadResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientMarkAllReadResponse>():
        return Failure(response.errorMessage);
    }
  }
}
