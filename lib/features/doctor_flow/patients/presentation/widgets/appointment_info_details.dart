import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class AppointmentInfoDetails extends StatelessWidget {
  final String date;
  final String time;
  final String day;
  final String month;
  final String dayNumber;

  const AppointmentInfoDetails({
    super.key,
    required this.date,
    required this.time,
    required this.day,
    required this.month,
    required this.dayNumber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.textColor100.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: AssetsManager.edit,
            height: 24,
            width: 24,
            color: theme.textColor300,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$day، $date",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: theme.medium16.copyWith(
                    color: theme.textColor600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.regular14.copyWith(
                    color: theme.textColor300,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.textColor600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  month,
                  style: theme.regular12.copyWith(color: theme.whiteColor),
                ),
                Text(
                  dayNumber,
                  style: theme.bold18.copyWith(color: theme.whiteColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
