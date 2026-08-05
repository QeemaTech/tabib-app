import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/profile/presentation/view_model/doctor_profile_state.dart';
import 'package:tabib_app/features/profile/presentation/view_model/doctor_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/widgets/doc_profile_header.dart';
import 'package:tabib_app/features/profile/presentation/widgets/doc_stat_card.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_menu_item.dart';

class DocProfileContent extends StatelessWidget {
  const DocProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<DoctorProfileViewModel, DoctorProfileState>(
            buildWhen: (previous, current) =>
                previous.profileState != current.profileState,
            builder: (context, state) {
              final profile = state.profileState.data;
              final lang = context.locale.languageCode;
              return DocProfileHeader(
                doctorName: profile?.localizedName(lang) ??
                    'appointments.drName'.tr(),
                doctorTitle: profile?.localizedTitle(lang).isNotEmpty == true
                    ? profile!.localizedTitle(lang)
                    : 'profile.doctor.orthopedicConsultant'.tr(),
                imagePath: profile?.hasAvatar == true
                    ? profile!.avatarUrl
                    : null,
              );
            },
          ),
          Column(
            children: [
              const _DocStatsRow(),
              const SizedBox(height: 24),
              ProfileMenuItem(
                title: 'profile.personalInfo'.tr(),
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
                title: 'profile.settings'.tr(),
                icon: Icons.settings_outlined,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              ProfileMenuItem(
                title: 'profile.experiences'.tr(),
                icon: Icons.work_outline,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocStatsRow extends StatelessWidget {
  const _DocStatsRow();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileViewModel, DoctorProfileState>(
      buildWhen: (previous, current) =>
          previous.profileState != current.profileState,
      builder: (context, state) {
        final rating = state.profileState.data?.ratingAvg;
        return Row(
          children: [
            Expanded(
              child: DocStatCard(
                title: 'profile.doctor.earnings'.tr(),
                value: '2,500',
                icon: AssetsManager.moneys,
                valueColor: const Color(0xFF4CAF50),
                prefixValue: '${'common.currency'.tr()} ',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DocStatCard(
                title: 'profile.doctor.patients'.tr(),
                value: '36',
                icon: AssetsManager.profile,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DocStatCard(
                title: 'profile.doctor.ratings'.tr(),
                value: rating != null && rating > 0
                    ? rating.toStringAsFixed(1)
                    : '4.3',
                icon: AssetsManager.edit,
                showStars: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
