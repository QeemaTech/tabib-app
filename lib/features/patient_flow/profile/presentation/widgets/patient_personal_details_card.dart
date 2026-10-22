import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/patient_flow/profile/presentation/widgets/patient_profile_detail_row.dart';

class PatientPersonalDetailsCard extends StatelessWidget {
  final PatientProfileEntity profile;

  const PatientPersonalDetailsCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final birthDate = DateTime.tryParse(profile.dateOfBirth);
    final formattedBirthDate = birthDate == null
        ? profile.dateOfBirth
        : DateFormat.yMMMMd(context.locale.toString()).format(birthDate);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          PatientProfileDetailRow(
            label: 'profile.personal.phone'.tr(),
            value: profile.phone,
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.email'.tr(),
            value: profile.email,
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.birthDate'.tr(),
            value: formattedBirthDate,
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.gender'.tr(),
            value: _genderLabel(profile.gender),
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.height'.tr(),
            value: profile.heightCm > 0
                ? '${profile.heightCm} ${'patients.details.cm'.tr()}'
                : '',
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.weight'.tr(),
            value: profile.weightKg > 0
                ? '${profile.weightKg} ${'patients.details.kg'.tr()}'
                : '',
          ),
          PatientProfileDetailRow(
            label: 'profile.personal.bloodType'.tr(),
            value: profile.bloodType,
            showDivider: false,
          ),
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
        return gender;
    }
  }
}
