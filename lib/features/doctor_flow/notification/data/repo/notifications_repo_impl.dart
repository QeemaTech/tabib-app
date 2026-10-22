import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/data_source/notifications_data_source.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/mapper/notifications_mapper.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notifications_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/mark_all_read_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/notifications_page_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/repo/notifications_repo.dart';

@LazySingleton(as: DoctorNotificationsRepo)
class DoctorNotificationsRepoImpl implements DoctorNotificationsRepo {
  final DoctorNotificationsDataSource dataSource;

  DoctorNotificationsRepoImpl(this.dataSource);

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
      case Success<DoctorNotificationsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorNotificationsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<NotificationEntity>> markAsRead(String id) async {
    final response = await dataSource.markAsRead(id);
    switch (response) {
      case Success<DoctorNotificationReadResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorNotificationReadResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<MarkAllReadEntity>> markAllAsRead() async {
    final response = await dataSource.markAllAsRead();
    switch (response) {
      case Success<DoctorMarkAllReadResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorMarkAllReadResponse>():
        return Failure(response.errorMessage);
    }
  }
}
