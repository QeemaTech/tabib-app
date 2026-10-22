import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/patient_flow/profile/domain/entities/patient_profile_entity.dart';

class PatientProfileHeaderCard extends StatelessWidget {
  final PatientProfileEntity profile;

  const PatientProfileHeaderCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final name = profile.localizedName(context.locale.languageCode);
    final age = profile.age;
    final genderLabel = _genderLabel(profile.gender);
    final metaParts = <String>[
      if (age != null) '$age ${'profile.years'.tr()}',
      if (genderLabel.isNotEmpty) genderLabel,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomImageView(
            imagePath: profile.hasAvatar
                ? profile.avatarUrl
                : AssetsManager.user,
            height: 88,
            width: 88,
            radius: BorderRadius.circular(44),
          ),
          const SizedBox(height: 16),
          Text(
            name.isEmpty ? '-' : name,
            textAlign: TextAlign.center,
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          if (metaParts.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              metaParts.join(' • '),
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
          ],
          if (profile.isVerified) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified,
                    size: 16,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'profile.personal.verified'.tr(),
                    style: theme.regular12.copyWith(color: theme.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ],
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
