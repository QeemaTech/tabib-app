import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_state.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_profile_summary_card.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:tabib_app/features/profile/presentation/widgets/user_profile_header.dart';

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        BlocBuilder<PatientProfileViewModel, PatientProfileState>(
          buildWhen: (previous, current) =>
              previous.profileState != current.profileState,
          builder: (context, state) {
            final profileState = state.profileState;
            final profile = profileState.data;
            return Column(
              children: [
                UserProfileHeader(
                  profile: profile,
                  isLoading: profileState.isLoading || profileState.isInitial,
                ),
                if (profile != null) ...[
                  const SizedBox(height: 24),
                  PatientProfileSummaryCard(profile: profile),
                ],
              ],
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
              title: 'profile.invoices'.tr(),
              subtitle: 'profile.invoicesSubtitle'.tr(),
              icon: Icons.receipt_long_outlined,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.patientInvoicesView);
              },
            ),
            Text(
              'profile.language'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ProfileMenuItem(
              title: 'profile.logout'.tr(),
              icon: Icons.logout,
              showTrailing: false,
              onTap: () async {
                await context.read<PatientProfileViewModel>().logout();
                await AppLocalStorage.clearAllSecuredData();
                SocketIoService.instance.disconnect();
                CachedUserRole.uiRole = 'user';
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.welcomeView,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
