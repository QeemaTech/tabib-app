import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/notification/domain/entities/notification_entity.dart';

class NotificationsState extends Equatable {
  final BaseState<List<NotificationEntity>> notificationsState;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final int unreadCount;
  final bool isMarkingAll;
  final String? markingId;
  final String? actionError;

  const NotificationsState({
    this.notificationsState = const BaseState(requestState: RequestState.init),
    this.page = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.unreadCount = 0,
    this.isMarkingAll = false,
    this.markingId,
    this.actionError,
  });

  NotificationsState copyWith({
    BaseState<List<NotificationEntity>>? notificationsState,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    int? unreadCount,
    bool? isMarkingAll,
    String? markingId,
    bool clearMarkingId = false,
    String? actionError,
    bool clearActionError = false,
  }) {
    return NotificationsState(
      notificationsState: notificationsState ?? this.notificationsState,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      unreadCount: unreadCount ?? this.unreadCount,
      isMarkingAll: isMarkingAll ?? this.isMarkingAll,
      markingId: clearMarkingId ? null : markingId ?? this.markingId,
      actionError: clearActionError ? null : actionError ?? this.actionError,
    );
  }

  @override
  List<Object?> get props => [
    notificationsState,
    page,
    hasMore,
    isLoadingMore,
    unreadCount,
    isMarkingAll,
    markingId,
    actionError,
  ];
}
