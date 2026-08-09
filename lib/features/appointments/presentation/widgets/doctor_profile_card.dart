import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/specialty_tag.dart';

class DoctorProfileCard extends StatelessWidget {
  final String avatarUrl;
  final String doctorName;
  final String specialtyLine;
  final String statusLabel;
  final List<String> specialties;
  final String dateTimeText;
  final String feeText;
  final VoidCallback? cancelAppointment;
  final VoidCallback? onConfirmPayment;
  final bool isPaid;

  const DoctorProfileCard({
    super.key,
    required this.avatarUrl,
    required this.doctorName,
    required this.specialtyLine,
    required this.statusLabel,
    required this.specialties,
    required this.dateTimeText,
    required this.feeText,
    this.cancelAppointment,
    this.onConfirmPayment,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final confirmedBg = theme.primaryColor.withValues(alpha: 0.1);
    final tagBgColor = theme.textColor100.withValues(alpha: 0.1);
    final metaStyle = theme.regular12.copyWith(
      color: theme.primaryColor,
      fontWeight: FontWeight.w500,
    );

    return Container(
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath:
                      avatarUrl.isNotEmpty ? avatarUrl : AssetsManager.doctor,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(30),
                  border: Border.all(
                    color: theme.primaryColor.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: theme.bold18.copyWith(color: theme.primaryColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        specialtyLine,
                        style: theme.regular14.copyWith(
                          color: theme.textColor300,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '4.88',
                            style: theme.bold12.copyWith(
                              color: theme.textColor300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: confirmedBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: theme.bold12.copyWith(
                      color: theme.primaryColor,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'appointments.specialties'.tr(),
              style: theme.medium13.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: specialties
                  .map(
                    (s) => SpecialtyTag(
                      label: s,
                      textColor: theme.primaryColor,
                      bgColor: tagBgColor,
                    ),
                  )
                  .toList(),
            ),
            Divider(
              color: theme.textColor100.withValues(alpha: 0.2),
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
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
                                color: theme.primaryColor.withValues(
                                  alpha: 0.12,
                                ),
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
