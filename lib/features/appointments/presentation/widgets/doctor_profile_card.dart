import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_card_facts.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_status_badge.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/doctor_profile_card_footer.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/specialty_tag.dart';

class DoctorProfileCard extends StatelessWidget {
  final String avatarUrl;
  final String doctorName;
  final String specialtyLine;
  final String status;
  final String statusLabel;
  final List<String> specialties;
  final String consultationType;
  final String consultationTypeLabel;
  final String dateText;
  final String timeText;
  final String durationText;
  final String feeText;
  final String complaint;
  final String symptoms;
  final String notes;
  final String cancelReason;
  final VoidCallback? cancelAppointment;
  final VoidCallback? onConfirmPayment;
  final VoidCallback? onCallTap;
  final String callIconPath;
  final String? callType;
  final bool isPaid;

  const DoctorProfileCard({
    super.key,
    required this.avatarUrl,
    required this.doctorName,
    required this.specialtyLine,
    required this.status,
    required this.statusLabel,
    required this.specialties,
    required this.dateText,
    required this.timeText,
    required this.feeText,
    this.consultationType = '',
    this.consultationTypeLabel = '',
    this.durationText = '',
    this.complaint = '',
    this.symptoms = '',
    this.notes = '',
    this.cancelReason = '',
    this.cancelAppointment,
    this.onConfirmPayment,
    this.onCallTap,
    this.callIconPath = AssetsManager.video,
    this.callType,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final tagBgColor = theme.textColor100.withValues(alpha: 0.15);

    return Container(
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.25)),
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
                  imagePath: avatarUrl.isNotEmpty
                      ? avatarUrl
                      : AssetsManager.doctor,
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
                      if (specialtyLine.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          specialtyLine,
                          style: theme.regular14.copyWith(
                            color: theme.textColor300,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppointmentStatusBadge(
                      status: status,
                      label: statusLabel,
                    ),
                    if (onCallTap != null) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: onCallTap,
                        behavior: HitTestBehavior.opaque,
                        child: Semantics(
                          label: (callType?.toUpperCase() == 'VOICE'
                                  ? 'calls.startVoice'
                                  : 'calls.startVideo')
                              .tr(),
                          button: true,
                          child: CustomImageView(
                            imagePath: callIconPath,
                            height: 22,
                            width: 22,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            if (specialties.isNotEmpty) ...[
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
                      (specialty) => SpecialtyTag(
                        label: specialty,
                        textColor: theme.primaryColor,
                        bgColor: tagBgColor,
                      ),
                    )
                    .toList(),
              ),
            ],
            Divider(color: theme.textColor100.withValues(alpha: 0.35)),
            AppointmentCardFacts(
              consultationType: consultationType,
              consultationTypeLabel: consultationTypeLabel,
              dateText: dateText,
              timeText: timeText,
              durationText: durationText,
              feeText: feeText,
              complaint: complaint,
              symptoms: symptoms,
              notes: notes,
              cancelReason: cancelReason,
            ),
            DoctorProfileCardFooter(
              cancelAppointment: cancelAppointment,
              onConfirmPayment: onConfirmPayment,
              isPaid: isPaid,
            ),
          ],
        ),
      ),
    );
  }
}
