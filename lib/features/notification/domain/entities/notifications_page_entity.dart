import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/notification/domain/entities/notification_entity.dart';

class NotificationsPageEntity extends Equatable {
  final List<NotificationEntity> items;
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final int unreadCount;

  const NotificationsPageEntity({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.unreadCount,
  });

  bool get hasMore => page < totalPages;

  @override
  List<Object?> get props => [
    items,
    page,
    limit,
    total,
    totalPages,
    unreadCount,
  ];
}
