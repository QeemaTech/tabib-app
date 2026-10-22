import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/doctor_flow/notification/domain/entities/notification_entity.dart';
import 'package:tabib_app/features/doctor_flow/notification/presentation/view_model/notifications_view_model.dart';
import 'package:tabib_app/features/doctor_flow/notification/presentation/widgets/notification_card.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationEntity> items;
  final bool isLoadingMore;
  final bool hasMore;

  const NotificationList({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 120 &&
            hasMore) {
          context.read<DoctorNotificationsViewModel>().loadMoreNotifications();
        }
        return false;
      },
      child: RefreshIndicator(
        color: theme.primaryColor,
        onRefresh: () => context
            .read<DoctorNotificationsViewModel>()
            .loadNotifications(showLoading: false),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: items.length + (isLoadingMore ? 1 : 0),
          separatorBuilder: (_, _) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            if (index >= items.length) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(color: theme.primaryColor),
                ),
              );
            }
            final item = items[index];
            return NotificationCard(
              title: item.title,
              description: item.body,
              time: _formatSentAt(item.sentAt, context.locale.languageCode),
              isRead: item.isRead,
              onTap: () => _onTap(context, item),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onTap(BuildContext context, NotificationEntity item) async {
    await context.read<DoctorNotificationsViewModel>().markAsRead(item.id);
    if (!context.mounted || item.appointmentId.isEmpty) return;
    Navigator.of(context).pushNamed(
      AppRoutes.patientsAppointmentDetailsView,
      arguments: item.appointmentId,
    );
  }
}

String _formatSentAt(String sentAt, String languageCode) {
  final parsed = DateTime.tryParse(sentAt)?.toLocal();
  if (parsed == null) return '';
  try {
    return DateFormat.yMMMd(languageCode).add_jm().format(parsed);
  } catch (_) {
    final month = parsed.month.toString().padLeft(2, '0');
    final day = parsed.day.toString().padLeft(2, '0');
    final hour = parsed.hour.toString().padLeft(2, '0');
    final minute = parsed.minute.toString().padLeft(2, '0');
    return '$day/$month/${parsed.year} $hour:$minute';
  }
}
