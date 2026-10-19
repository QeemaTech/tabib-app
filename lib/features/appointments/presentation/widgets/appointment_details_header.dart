import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/appointments/presentation/utils/appointment_ui_helpers.dart';

class AppointmentDetailsHeader extends StatelessWidget {
  final PatientAppointmentDetailsEntity details;

  const AppointmentDetailsHeader({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final doctor = details.doctor;
    final specialty = doctor.specialties.isNotEmpty
        ? doctor.specialties.first.localizedName(languageCode)
        : '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: doctor.avatarUrl.isNotEmpty
                ? doctor.avatarUrl
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
                  doctor.localizedName(languageCode),
                  style: theme.bold18.copyWith(color: theme.primaryColor),
                ),
                if (specialty.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                ],
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: theme.primaryColor, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      doctor.ratingAvg.toStringAsFixed(1),
                      style: theme.bold12.copyWith(color: theme.textColor300),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              appointmentStatusLabel(details.status),
              style: theme.bold12.copyWith(color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
