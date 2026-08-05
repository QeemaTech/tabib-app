import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_state.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:tabib_app/features/profile/presentation/widgets/user_profile_header.dart';

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        BlocBuilder<PatientProfileViewModel, PatientProfileState>(
          buildWhen: (previous, current) =>
              previous.profileState != current.profileState,
          builder: (context, state) {
            final profileState = state.profileState;
            return UserProfileHeader(
              profile: profileState.data,
              isLoading: profileState.isLoading || profileState.isInitial,
            );
          },
        ),
        const SizedBox(height: 32),
        Column(
          spacing: 12,
          children: [
            ProfileMenuItem(
              title: 'profile.personalInfo'.tr(),
              subtitle: 'profile.personalSubtitle'.tr(),
              icon: Icons.person_outline,
              onTap: () async {
                await Navigator.of(
                  context,
                ).pushNamed(AppRoutes.patientPersonalInfoView);
                if (context.mounted) {
                  context.read<PatientProfileViewModel>().refreshProfile();
                }
              },
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
            ElevatedButton(
              onPressed: () {
                AppLocalStorage.clearAllSecuredData();
                CachedUserRole.uiRole = 'user';
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.welcomeView,
                  (route) => false,
                );
              },
              child: Text('Logout'.tr()),
            ),
          ],
        ),
      ],
    );
  }
}
