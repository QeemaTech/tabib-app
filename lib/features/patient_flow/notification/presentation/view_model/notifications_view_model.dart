import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/entities/mark_all_read_entity.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/entities/notifications_page_entity.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/repo/notifications_repo.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/view_model/notifications_state.dart';

@injectable
class PatientNotificationsViewModel extends Cubit<NotificationsState> {
  final PatientNotificationsRepo notificationsRepo;
  static const _pageLimit = 20;

  PatientNotificationsViewModel({required this.notificationsRepo})
    : super(const NotificationsState());

  Future<void> loadNotifications({bool showLoading = true}) async {
    if (showLoading) {
      emit(
        state.copyWith(
          notificationsState: BaseState.loading(),
          clearActionError: true,
        ),
      );
    }
    final result = await notificationsRepo.getNotifications(
      page: 1,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<NotificationsPageEntity>():
        emit(
          state.copyWith(
            notificationsState: BaseState.loaded(result.data.items),
            page: result.data.page,
            hasMore: result.data.hasMore,
            unreadCount: result.data.unreadCount,
            isLoadingMore: false,
          ),
        );
      case Failure<NotificationsPageEntity>():
        emit(
          state.copyWith(
            notificationsState: BaseState.error(result.errorMessage),
            isLoadingMore: false,
          ),
        );
    }
  }

  Future<void> loadMoreNotifications() async {
    if (!state.hasMore ||
        state.isLoadingMore ||
        state.notificationsState.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true));
    final result = await notificationsRepo.getNotifications(
      page: state.page + 1,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<NotificationsPageEntity>():
        final current = state.notificationsState.data ?? const [];
        emit(
          state.copyWith(
            notificationsState: BaseState.loaded([
              ...current,
              ...result.data.items,
            ]),
            page: result.data.page,
            hasMore: result.data.hasMore,
            unreadCount: result.data.unreadCount,
            isLoadingMore: false,
          ),
        );
      case Failure<NotificationsPageEntity>():
        emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> markAsRead(String id) async {
    final items = state.notificationsState.data;
    if (items == null || state.markingId != null) return;
    final index = items.indexWhere((item) => item.id == id);
    if (index == -1 || items[index].isRead) return;

    emit(state.copyWith(markingId: id, clearActionError: true));
    final result = await notificationsRepo.markAsRead(id);
    switch (result) {
      case Success<NotificationEntity>():
        final updated = [...items];
        updated[index] = items[index].copyWith(isRead: true);
        emit(
          state.copyWith(
            notificationsState: BaseState.loaded(updated),
            unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
            clearMarkingId: true,
          ),
        );
      case Failure<NotificationEntity>():
        emit(
          state.copyWith(
            clearMarkingId: true,
            actionError: result.errorMessage,
          ),
        );
    }
  }

  Future<void> markAllAsRead() async {
    if (state.isMarkingAll || state.unreadCount == 0) return;
    emit(state.copyWith(isMarkingAll: true, clearActionError: true));
    final result = await notificationsRepo.markAllAsRead();
    switch (result) {
      case Success<MarkAllReadEntity>():
        final items = state.notificationsState.data ?? const [];
        emit(
          state.copyWith(
            isMarkingAll: false,
            unreadCount: 0,
            notificationsState: BaseState.loaded([
              for (final item in items) item.copyWith(isRead: true),
            ]),
          ),
        );
      case Failure<MarkAllReadEntity>():
        emit(
          state.copyWith(isMarkingAll: false, actionError: result.errorMessage),
        );
    }
  }
}
