import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_prescription_details_entity.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/utils/record_date_format.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/widgets/medication_card.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/widgets/prescription_doctor_info.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/widgets/prescription_section.dart';

class PrescriptionDetailsContent extends StatelessWidget {
  final PatientPrescriptionDetailsEntity details;

  const PrescriptionDetailsContent({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final when = formatRecordTimestamp(details.occurredAt);
    final referenceLabel = details.localizedReferenceLabel(languageCode);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        details.actions.hasAny ? 120 : 20,
      ),
      child: Column(
        children: [
          PrescriptionDoctorInfo(
            doctorName: details.doctor.localizedName(languageCode),
            specialty: details.doctor.localizedSpecialty(languageCode),
            date: when.date,
            time: when.time,
            referenceLabel: referenceLabel,
            rxNumber: details.referenceNumber,
            imageUrl: details.doctor.avatarUrl.isEmpty
                ? null
                : details.doctor.avatarUrl,
          ),
          if (details.diagnosisAr.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.diagnosis'.tr(),
              child: Text(
                details.diagnosisAr,
                style: theme.medium16.copyWith(color: theme.textColor600),
              ),
            ),
          ],
          if (details.medications.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.medications'.tr(),
              child: Column(
                children: [
                  for (var i = 0; i < details.medications.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    MedicationCard(
                      medication: details.medications[i],
                      languageCode: languageCode,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
