import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_details_entity.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/doctor_header_stat.dart';

class DoctorHeaderCard extends StatelessWidget {
  final DoctorDetailsEntity doctor;

  const DoctorHeaderCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final specialty = doctor.specialties.isNotEmpty
        ? doctor.specialties.first.localizedName(languageCode)
        : doctor.clinic?.nameAr ?? '';
    final location = doctor.clinic?.locationLabel ?? '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.textColor600.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomImageView(
            imagePath: doctor.avatarUrl.isNotEmpty
                ? doctor.avatarUrl
                : AssetsManager.doctor,
            height: 80,
            width: 80,
            radius: BorderRadius.circular(40),
          ),
          const SizedBox(height: 12),
          Text(
            doctor.localizedFullName(languageCode),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          if (specialty.isNotEmpty)
            Text(
              specialty,
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DoctorHeaderStat(
                icon: Icons.star,
                text:
                    '${doctor.ratingAvg.toStringAsFixed(1)} (${doctor.ratingCount} ${'home.appointmentDetails.reviews'.tr()})',
                iconColor: theme.primaryColor,
              ),
              const SizedBox(width: 12),
              DoctorHeaderStat(
                icon: Icons.access_time,
                text:
                    '${doctor.experienceYears} ${'home.appointmentDetails.years'.tr()}',
                iconColor: theme.textColor300,
              ),
            ],
          ),
          if (location.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: theme.textColor300,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    location,
                    style: theme.regular12.copyWith(color: theme.textColor300),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
