import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_medication_entity.dart';
import 'package:tabib_app/features/records/presentation/widgets/medication_info_row.dart';

class MedicationCard extends StatelessWidget {
  final PatientRecordMedicationEntity medication;
  final String languageCode;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final name = medication.localizedName(languageCode);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (name.isNotEmpty)
            Text(name, style: theme.bold18.copyWith(color: theme.textColor600)),
          if (medication.formAr.isNotEmpty)
            Text(
              medication.formAr,
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
          MedicationInfoRow(
            label: 'records.details.dose'.tr(),
            value: medication.doseAr,
            secondLabel: 'records.details.frequency'.tr(),
            secondValue: medication.frequencyAr,
          ),
          MedicationInfoRow(
            label: 'records.details.duration'.tr(),
            value: medication.durationAr,
            secondLabel: 'records.details.timing'.tr(),
            secondValue: medication.timingAr,
          ),
          if (medication.noteAr.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                medication.noteAr,
                style: theme.regular12.copyWith(color: theme.textColor600),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

