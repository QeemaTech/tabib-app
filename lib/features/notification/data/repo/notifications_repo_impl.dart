import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/notification/data/data_source/notifications_data_source.dart';
import 'package:tabib_app/features/notification/data/mapper/notifications_mapper.dart';
import 'package:tabib_app/features/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/notification/data/models/response/notifications_response.dart';
import 'package:tabib_app/features/notification/domain/entities/mark_all_read_entity.dart';
import 'package:tabib_app/features/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/notification/domain/entities/notifications_page_entity.dart';
import 'package:tabib_app/features/notification/domain/repo/notifications_repo.dart';

@LazySingleton(as: NotificationsRepo)
class NotificationsRepoImpl implements NotificationsRepo {
  final NotificationsDataSource dataSource;

  NotificationsRepoImpl(this.dataSource);

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
      case Success<NotificationsResponse>():
        return Success(response.data.toEntity());
      case Failure<NotificationsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<NotificationEntity>> markAsRead(String id) async {
    final response = await dataSource.markAsRead(id);
    switch (response) {
      case Success<NotificationReadResponse>():
        return Success(response.data.toEntity());
      case Failure<NotificationReadResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<MarkAllReadEntity>> markAllAsRead() async {
    final response = await dataSource.markAllAsRead();
    switch (response) {
      case Success<MarkAllReadResponse>():
        return Success(response.data.toEntity());
      case Failure<MarkAllReadResponse>():
        return Failure(response.errorMessage);
    }
  }
}
