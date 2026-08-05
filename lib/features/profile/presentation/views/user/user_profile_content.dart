import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_menu_item.dart';

import '../../../../../core/constant/assets_manager.dart';
import '../../../../../core/utilities/custom_image_view.dart';

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        const SizedBox(height: 60),
        // Profile Header
        Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomImageView(
                    imagePath: AssetsManager.user,
                    height: 100,
                    width: 100,
                    radius: BorderRadius.circular(50),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'appointments.drName'.tr(),
                style: theme.bold18.copyWith(color: theme.textColor600),
              ),
              const SizedBox(height: 4),
              Text(
                '25 ${'profile.years'.tr()} • ${'profile.male'.tr()}',
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Menu Items
        Column(
          spacing: 12,
          children: [
            ProfileMenuItem(
              title: 'profile.personalInfo'.tr(),
              subtitle: 'profile.personalSubtitle'.tr(),
              icon: Icons.person_outline,
              onTap: () => context.pushName(AppRoutes.patientPersonalInfoView),
            ),
            ProfileMenuItem(
              title: 'profile.medicalProfile'.tr(),
              subtitle: 'profile.medicalSubtitle'.tr(),
              icon: Icons.favorite_border,
              onTap: () {},
            ),
            ProfileMenuItem(
              title: 'profile.settings'.tr(),
              subtitle: 'profile.settingsSubtitle'.tr(),
              icon: Icons.settings_outlined,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
