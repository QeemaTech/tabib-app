import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/profile/domain/entities/doctor_profile_entity.dart';

class DocProfileHeader extends StatelessWidget {
  final DoctorProfileEntity? profile;
  final bool isLoading;

  const DocProfileHeader({
    super.key,
    this.profile,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final name = profile?.localizedName(languageCode) ?? '';
    final title = profile?.localizedTitle(languageCode) ?? '';
    final specialty = profile?.mainSpecialty?.localizedName(languageCode) ?? '';
    final showRating = (profile?.ratingCount ?? 0) > 0;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.textColor100.withValues(alpha: 0.4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: profile != null && profile!.hasAvatar
                  ? profile!.avatarUrl
                  : AssetsManager.doctor,
              height: 72,
              width: 72,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.isEmpty ? '-' : name,
                    style: theme.bold18.copyWith(color: theme.textColor600),
                  ),
                  if (title.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: theme.regular14.copyWith(color: theme.textColor300),
                    ),
                  ],
                  if (specialty.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: theme.regular14.copyWith(color: theme.primaryColor),
                    ),
                  ],
                  if (profile != null &&
                      profile!.verificationStatus.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      _verificationLabel(profile!.verificationStatus),
                      style: theme.bold12.copyWith(color: theme.primaryColor),
                    ),
                  ],
                  if (showRating) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${profile!.ratingAvg.toStringAsFixed(1)} (${profile!.ratingCount})',
                      style: theme.regular12.copyWith(color: theme.textColor300),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _verificationLabel(String status) {
    switch (status.toUpperCase()) {
      case 'VERIFIED':
      case 'APPROVED':
        return 'profile.doctor.statusVerified'.tr();
      case 'REJECTED':
        return 'profile.doctor.statusRejected'.tr();
      case 'PENDING':
        return 'profile.doctor.statusPending'.tr();
      default:
        return status;
    }
  }
}
