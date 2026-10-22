import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/notification/presentation/view_model/notifications_view_model.dart';

class NotificationMarkAllAction extends StatelessWidget {
  const NotificationMarkAllAction({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final unreadCount = context.select(
      (DoctorNotificationsViewModel cubit) => cubit.state.unreadCount,
    );
    final isMarkingAll = context.select(
      (DoctorNotificationsViewModel cubit) => cubit.state.isMarkingAll,
    );
    if (unreadCount <= 0) return const SizedBox.shrink();
    if (isMarkingAll) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: 16),
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.primaryColor,
            ),
          ),
        ),
      );
    }
    return TextButton(
      onPressed: () => context.read<DoctorNotificationsViewModel>().markAllAsRead(),
      child: Text(
        'notifications.markAllRead'.tr(),
        style: theme.regular12.copyWith(color: theme.primaryColor),
      ),
    );
  }
}
