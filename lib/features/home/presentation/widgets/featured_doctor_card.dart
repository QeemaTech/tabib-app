import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/home/domain/entities/featured_doctor_entity.dart';

class FeaturedDoctorCard extends StatelessWidget {
  final FeaturedDoctorEntity doctor;
  final VoidCallback? onTap;

  const FeaturedDoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final specialty = doctor.specialties.isNotEmpty
        ? doctor.specialties.first
        : doctor.clinicName;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.textColor100.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: theme.textColor600.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomImageView(
                      imagePath: doctor.avatarUrl.isNotEmpty
                          ? doctor.avatarUrl
                          : AssetsManager.doctor,
                      height: 64,
                      width: 64,
                      radius: BorderRadius.circular(32),
                    ),
                    if (doctor.isOnline)
                      PositionedDirectional(
                        end: 2,
                        bottom: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.whiteColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.localizedFullName(languageCode),
                        style: theme.bold18.copyWith(color: theme.textColor600),
                      ),
                      Text(
                        specialty,
                        style: theme.regular14.copyWith(
                          color: theme.textColor300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: theme.primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            doctor.ratingAvg.toStringAsFixed(1),
                            style: theme.bold12.copyWith(
                              color: theme.textColor300,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${doctor.ratingCount})',
                            style: theme.regular12.copyWith(
                              color: theme.textColor200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (doctor.specialties.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: doctor.specialties
                    .map(
                      (spec) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor300,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          spec,
                          style: theme.medium13.copyWith(
                            fontSize: 12,
                            color: theme.whiteColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                CustomImageView(
                  imagePath: AssetsManager.moneys,
                  height: 24,
                  width: 24,
                  color: theme.textColor300,
                ),
                const SizedBox(width: 8),
                Text(
                  '${doctor.consultationFee} ${'home.search.currency'.tr()}',
                  style: theme.regular12.copyWith(color: theme.blackColor,fontWeight: FontWeight.bold,fontSize: 16),
                ),
                const Spacer(),
                Text(
                  '${doctor.experienceYears} ${'home.appointmentDetails.years'.tr()}',
                  style: theme.regular12.copyWith(color: theme.blackColor,fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
