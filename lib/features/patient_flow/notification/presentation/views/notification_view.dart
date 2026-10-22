import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/patient_flow/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/view_model/notifications_state.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/view_model/notifications_view_model.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/widgets/notification_list.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/widgets/notification_mark_all_action.dart';
import 'package:tabib_app/features/patient_flow/notification/presentation/widgets/notification_status_message.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocListener<PatientNotificationsViewModel, NotificationsState>(
      listenWhen: (previous, current) =>
          previous.actionError != current.actionError &&
          current.actionError != null,
      listener: (context, state) {
        final message = state.actionError;
        if (message == null || message.isEmpty) return;
        CustomToast.error(context, message);
      },
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text('notifications.title'.tr(), style: theme.bold18),
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          actions: const [NotificationMarkAllAction()],
        ),
        body: BlocBuilder<PatientNotificationsViewModel, NotificationsState>(
          buildWhen: (previous, current) =>
              previous.notificationsState != current.notificationsState ||
              previous.isLoadingMore != current.isLoadingMore ||
              previous.hasMore != current.hasMore,
          builder: (context, state) {
            final notifications = state.notificationsState;
            if (notifications.isLoading || notifications.isInitial) {
              return Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              );
            }
            if (notifications.isError) {
              return NotificationStatusMessage(
                message: notifications.errorMessage ?? 'errors.unknown'.tr(),
                onRetry: () =>
                    context.read<PatientNotificationsViewModel>().loadNotifications(),
              );
            }
            final items = notifications.data ?? const <NotificationEntity>[];
            if (items.isEmpty) {
              return RefreshIndicator(
                color: theme.primaryColor,
                onRefresh: () => context
                    .read<PatientNotificationsViewModel>()
                    .loadNotifications(showLoading: false),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: Center(
                        child: Text(
                          'notifications.empty'.tr(),
                          style: theme.regular14.copyWith(
                            color: theme.textColor300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return NotificationList(
              items: items,
              isLoadingMore: state.isLoadingMore,
              hasMore: state.hasMore,
            );
          },
        ),
      ),
    );
  }
}
