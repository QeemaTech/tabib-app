import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/schedule/presentation/utils/schedule_display.dart';

class ScheduleDayCard extends StatelessWidget {
  final int dayOfWeek;
  final ScheduleDayEntity? day;
  final VoidCallback onTap;

  const ScheduleDayCard({
    super.key,
    required this.dayOfWeek,
    required this.day,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isActive = day?.isActive ?? false;
    final slots = day?.slots ?? const [];
    final summary = isActive && slots.isNotEmpty
        ? '${ScheduleDisplay.slotsSummary(slots)}'
            ' · ${slots.first.slotDurationMin}'
            '${'schedule.minutesShort'.tr()}'
        : 'schedule.off'.tr();

    return Material(
      color: theme.whiteColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ScheduleDisplay.dayKey(dayOfWeek).tr(),
                      style: theme.bold18.copyWith(
                        fontSize: 16,
                        color: theme.textColor600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      summary,
                      style: theme.regular14.copyWith(
                        color: isActive
                            ? theme.textColor300
                            : theme.textColor200,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? theme.primaryColor300
                      : theme.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isActive
                      ? 'schedule.active'.tr()
                      : 'schedule.inactive'.tr(),
                  style: theme.bold12.copyWith(
                    color: isActive
                        ? theme.primaryColor
                        : theme.textColor200,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: theme.textColor200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
