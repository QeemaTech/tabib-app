import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class DoctorProfileCardFooter extends StatelessWidget {
  final String dateTimeText;
  final String feeText;
  final VoidCallback? cancelAppointment;
  final VoidCallback? onConfirmPayment;
  final bool isPaid;

  const DoctorProfileCardFooter({
    super.key,
    required this.dateTimeText,
    required this.feeText,
    this.cancelAppointment,
    this.onConfirmPayment,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final metaStyle = theme.regular12.copyWith(
      color: theme.primaryColor,
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomImageView(
              height: 12,
              imagePath: AssetsManager.appointments,
            ),
            const SizedBox(width: 6),
            Text(dateTimeText, style: metaStyle),
          ],
        ),
        Row(
          children: [
            CustomImageView(imagePath: AssetsManager.moneys),
            Text(feeText, style: metaStyle),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (cancelAppointment != null)
              GestureDetector(
                onTap: cancelAppointment,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'appointments.cancelAppointment'.tr(),
                    style: theme.regular12.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
            if (isPaid)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'appointments.paid'.tr(),
                  style: theme.regular12.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else if (onConfirmPayment != null)
              GestureDetector(
                onTap: onConfirmPayment,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'appointments.confirmPayment'.tr(),
                    style: theme.regular12.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
