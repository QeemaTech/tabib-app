import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/profile/presentation/widgets/patient_profile_detail_row.dart';

class PatientProfileSummaryCard extends StatelessWidget {
  final PatientProfileEntity profile;

  const PatientProfileSummaryCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final rows = <({String label, String value})>[
      if (profile.bloodType.trim().isNotEmpty)
        (
          label: 'profile.personal.bloodType'.tr(),
          value: profile.bloodType,
        ),
      if (profile.heightCm > 0)
        (
          label: 'profile.personal.height'.tr(),
          value: '${profile.heightCm} ${'patients.details.cm'.tr()}',
        ),
      if (profile.weightKg > 0)
        (
          label: 'profile.personal.weight'.tr(),
          value: '${profile.weightKg} ${'patients.details.kg'.tr()}',
        ),
      if (profile.allergies.trim().isNotEmpty)
        (
          label: 'profile.personal.allergies'.tr(),
          value: profile.allergies,
        ),
      if (profile.chronicConditions.trim().isNotEmpty)
        (
          label: 'profile.personal.chronicConditions'.tr(),
          value: profile.chronicConditions,
        ),
      if (profile.currentMedications.trim().isNotEmpty)
        (
          label: 'profile.personal.currentMedications'.tr(),
          value: profile.currentMedications,
        ),
      if (profile.hasMedicationAllergy)
        (
          label: 'profile.personal.medicationAllergy'.tr(),
          value: 'profile.personal.yes'.tr(),
        ),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();

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
          for (var index = 0; index < rows.length; index++)
            PatientProfileDetailRow(
              label: rows[index].label,
              value: rows[index].value,
              showDivider: index < rows.length - 1,
            ),
        ],
      ),
    );
  }
}
