import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';

class UserProfileHeader extends StatelessWidget {
  final PatientProfileEntity? profile;
  final bool isLoading;

  const UserProfileHeader({
    super.key,
    this.profile,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final name = profile?.localizedName(context.locale.languageCode) ?? '';
    final age = profile?.age;
    final genderLabel = _genderLabel(profile?.gender ?? '');
    final metaParts = <String>[
      if (age != null) '$age ${'profile.years'.tr()}',
      if (genderLabel.isNotEmpty) genderLabel,
    ];

    return Skeletonizer(
      enabled: isLoading,
      child: Center(
        child: Column(
          children: [
            CustomImageView(
              imagePath: profile != null && profile!.hasAvatar
                  ? profile!.avatarUrl
                  : AssetsManager.user,
              height: 100,
              width: 100,
              radius: BorderRadius.circular(50),
            ),
            const SizedBox(height: 16),
            Text(
              name.isEmpty ? '-' : name,
              style: theme.bold18.copyWith(color: theme.textColor600),
            ),
            if (isLoading || metaParts.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                metaParts.isEmpty ? '-' : metaParts.join(' • '),
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
            ],
            if (profile != null && profile!.phone.trim().isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                profile!.phone,
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
            ],
            if (profile?.isVerified == true) ...[
              const SizedBox(height: 8),
              Text(
                'profile.personal.verified'.tr(),
                style: theme.bold12.copyWith(color: theme.primaryColor),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _genderLabel(String gender) {
    switch (gender.toUpperCase()) {
      case 'MALE':
        return 'profile.male'.tr();
      case 'FEMALE':
        return 'profile.female'.tr();
      default:
        return '';
    }
  }
}
