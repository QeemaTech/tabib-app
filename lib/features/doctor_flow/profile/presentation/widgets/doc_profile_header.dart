import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/entities/doctor_profile_entity.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doctor_profile_meta_chip.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doctor_profile_status_pill.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/star_review.dart';

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
    final status = profile?.verificationStatus.trim() ?? '';
    final rejection = profile?.rejectionReason?.trim() ?? '';
    final years = profile?.experienceYears ?? 0;

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.textColor100.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: theme.blackColor.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 96,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [theme.primaryColor, theme.primaryColor300],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -44,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: CustomImageView(
                      imagePath: profile != null && profile!.hasAvatar
                          ? profile!.avatarUrl
                          : AssetsManager.doctor,
                      height: 88,
                      width: 88,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(44),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 56),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Column(
                children: [
                  Text(
                    name.isEmpty ? '-' : name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bold18.copyWith(color: theme.textColor600),
                  ),
                  if (title.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.regular14.copyWith(color: theme.textColor300),
                    ),
                  ],
                  if (specialty.isNotEmpty ||
                      years > 0 ||
                      profile?.isOnline == true) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (specialty.isNotEmpty)
                          DoctorProfileMetaChip(
                            label: specialty,
                            icon: Icons.medical_services_outlined,
                          ),
                        if (years > 0)
                          DoctorProfileMetaChip(
                            label: '$years ${'profile.years'.tr()}',
                            icon: Icons.workspace_premium_outlined,
                          ),
                        if (profile?.isOnline == true)
                          DoctorProfileMetaChip(
                            label: 'common.availableNow'.tr(),
                            icon: Icons.circle,
                            iconSize: 8,
                          ),
                      ],
                    ),
                  ],
                  if (showRating) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StarReview(rating: profile!.ratingAvg),
                        const SizedBox(width: 6),
                        Text(
                          '${profile!.ratingAvg.toStringAsFixed(1)} (${profile!.ratingCount})',
                          style: theme.regular12.copyWith(
                            color: theme.textColor300,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (status.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    DoctorProfileStatusPill(status: status),
                  ],
                  if (rejection.isNotEmpty && profile?.isVerified != true) ...[
                    const SizedBox(height: 8),
                    Text(
                      rejection,
                      textAlign: TextAlign.center,
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
}
