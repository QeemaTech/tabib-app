import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patients/presentation/utils/patient_file_display.dart';

class PatientFileMedicalOverview extends StatelessWidget {
  final String bloodType;
  final String allergies;
  final String chronicConditions;

  const PatientFileMedicalOverview({
    super.key,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final conditions = chronicConditions
        .split(RegExp(r'[,،]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EBF1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'patients.details.previousDiagnoses'.tr(),
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          const SizedBox(height: 8),
          if (conditions.isEmpty)
            Text(
              '----',
              style: theme.medium13.copyWith(color: theme.primaryColor),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final condition in conditions)
                  _DiagnosisChip(label: condition),
              ],
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "${'patients.details.bloodGroup'.tr()}: ",
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
              Text(
                patientFileDisplay(bloodType),
                style: theme.medium16.copyWith(color: theme.textColor600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'patients.details.allergies'.tr(),
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  patientFileDisplay(allergies),
                  style: theme.medium16.copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagnosisChip extends StatelessWidget {
  final String label;

  const _DiagnosisChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: theme.medium13.copyWith(color: theme.primaryColor),
      ),
    );
  }
}
