import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/view_model/doctor_profile_state.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/view_model/doctor_profile_view_model.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doc_profile_header.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doc_profile_stats_row.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/doctor_profile_summary_card.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/profile_language_section.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/profile_menu_item.dart';

class DocProfileContent extends StatelessWidget {
  const DocProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        BlocBuilder<DoctorProfileViewModel, DoctorProfileState>(
          buildWhen: (previous, current) =>
              previous.profileState != current.profileState,
          builder: (context, state) {
            final profileState = state.profileState;
            final profile = profileState.data;
            return Column(
              children: [
                DocProfileHeader(
                  profile: profile,
                  isLoading: profileState.isLoading || profileState.isInitial,
                ),
                if (profile != null) ...[
                  const SizedBox(height: 16),
                  DoctorProfileSummaryCard(profile: profile),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        const DocProfileStatsRow(),
        const SizedBox(height: 24),
        Text(
          'profile.doctor.account'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
        const SizedBox(height: 12),
        ProfileMenuItem(
          title: 'profile.personalInfo'.tr(),
          subtitle: 'profile.doctor.personalInfoSubtitle'.tr(),
          icon: Icons.person_outline,
          onTap: () async {
            await Navigator.of(context).pushNamed(
              AppRoutes.doctorPersonalInfoView,
            );
            if (context.mounted) {
              context.read<DoctorProfileViewModel>().refreshProfile();
            }
          },
        ),
        const SizedBox(height: 12),
        ProfileMenuItem(
          title: 'profile.doctor.completeProfile'.tr(),
          subtitle: 'profile.doctor.completeProfileSubtitle'.tr(),
          icon: Icons.assignment_ind_outlined,
          onTap: () async {
            await Navigator.of(context).pushNamed(
              AppRoutes.completeProfileView,
              arguments: 'doctor',
            );
            if (context.mounted) {
              context.read<DoctorProfileViewModel>().refreshProfile();
            }
          },
        ),
        const SizedBox(height: 12),
        const ProfileLanguageSection(),
        const SizedBox(height: 12),
        ProfileMenuItem(
          title: 'profile.logout'.tr(),
          icon: Icons.logout,
          showTrailing: false,
          onTap: () async {
            await context.read<DoctorProfileViewModel>().logout();
            await AppLocalStorage.clearAllSecuredData();
            SocketIoService.instance.disconnect();
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginView,
                (route) => false,
              );
            }
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
