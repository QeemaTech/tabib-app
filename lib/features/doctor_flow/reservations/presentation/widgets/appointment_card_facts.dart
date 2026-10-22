import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/appointment_card_fact_row.dart';

class AppointmentCardFacts extends StatelessWidget {
  final String consultationType;
  final String consultationTypeLabel;
  final String dateText;
  final String timeText;
  final String durationText;
  final String feeText;
  final String complaint;
  final String symptoms;
  final String notes;
  final String phone;
  final String cancelReason;

  const AppointmentCardFacts({
    super.key,
    required this.consultationType,
    required this.consultationTypeLabel,
    required this.dateText,
    required this.timeText,
    required this.durationText,
    required this.feeText,
    this.complaint = '',
    this.symptoms = '',
    this.notes = '',
    this.phone = '',
    this.cancelReason = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final type = consultationType.toUpperCase();
    final iconPath = type == 'CHAT' ? AssetsManager.messages : AssetsManager.video;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (consultationTypeLabel.isNotEmpty)
          Row(
            children: [
              CustomImageView(
                imagePath: iconPath,
                height: 16,
                width: 16,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  durationText.isEmpty
                      ? consultationTypeLabel
                      : '$consultationTypeLabel · $durationText',
                  style: theme.medium13.copyWith(color: theme.primaryColor),
                ),
              ),
            ],
          ),
        if (dateText.isNotEmpty) ...[
          const SizedBox(height: 10),
          AppointmentCardFactRow(
            label: 'appointments.date'.tr(),
            value: dateText,
          ),
        ],
        if (timeText.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppointmentCardFactRow(
            label: 'appointments.time'.tr(),
            value: timeText,
          ),
        ],
        if (feeText.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppointmentCardFactRow(
            label: 'appointments.fee'.tr(),
            value: feeText,
          ),
        ],
        if (complaint.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppointmentCardFactRow(
            label: 'appointments.complaint'.tr(),
            value: complaint,
          ),
        ],
        if (symptoms.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppointmentCardFactRow(
            label: 'appointments.symptoms'.tr(),
            value: symptoms,
          ),
        ],
        if (notes.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppointmentCardFactRow(
            label: 'appointments.notes'.tr(),
            value: notes,
          ),
        ],
        if (phone.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppointmentCardFactRow(
            label: 'appointments.phone'.tr(),
            value: phone,
          ),
        ],
        if (cancelReason.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppointmentCardFactRow(
            label: 'appointments.cancelReason'.tr(),
            value: cancelReason,
          ),
        ],
      ],
    );
  }
}
