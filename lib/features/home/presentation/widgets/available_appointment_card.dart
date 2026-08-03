import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class AvailableAppointmentCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback? onTap;

  const AvailableAppointmentCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isActive = isAvailable && isSelected;
    final textColor = isActive
        ? theme.whiteColor
        : isAvailable
            ? theme.textColor300
            : theme.textColor100;
    final statusColor = isActive
        ? theme.whiteColor
        : isAvailable
            ? theme.primaryColor
            : theme.textColor200;
    final backgroundColor = isActive
        ? theme.primaryColor
        : isAvailable
            ? theme.whiteColor
            : theme.backgroundColor;

    return InkWell(
      onTap: isAvailable ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Card.outlined(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(
                startTime,
                style: theme.regular14.copyWith(color: textColor),
              ),
              const SizedBox(width: 4),
              Text(
                'home.doctorDetails.startTime'.tr(),
                style: theme.regular14.copyWith(color: textColor),
              ),
              const Spacer(),
              Text(
                isAvailable
                    ? 'home.doctorDetails.available'.tr()
                    : 'home.doctorDetails.unavailable'.tr(),
                style: theme.bold12.copyWith(color: statusColor),
              ),
              const Spacer(),
              Text(
                endTime,
                style: theme.regular14.copyWith(color: textColor),
              ),
              const SizedBox(width: 4),
              Text(
                'home.doctorDetails.endTime'.tr(),
                style: theme.regular14.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
