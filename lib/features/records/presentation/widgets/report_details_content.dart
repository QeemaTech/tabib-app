import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/records/domain/entities/patient_report_details_entity.dart';
import 'package:tabib_app/features/records/presentation/utils/record_date_format.dart';
import 'package:tabib_app/features/records/presentation/widgets/prescription_doctor_info.dart';
import 'package:tabib_app/features/records/presentation/widgets/prescription_section.dart';

class ReportDetailsContent extends StatelessWidget {
  final PatientReportDetailsEntity details;

  const ReportDetailsContent({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final when = formatRecordTimestamp(details.occurredAt);
    final diagnosis = details.displayDiagnosis(languageCode);
    final textStyle = theme.regular14.copyWith(
      color: theme.textColor600,
      height: 1.5,
    );

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
            referenceLabel: details.localizedReferenceLabel(languageCode),
            rxNumber: details.referenceNumber,
            imageUrl: details.doctor.avatarUrl.isEmpty
                ? null
                : details.doctor.avatarUrl,
          ),
          if (details.visitTypeAr.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.visitType'.tr(),
              child: Text(details.visitTypeAr, style: textStyle),
            ),
          ],
          if (diagnosis.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.diagnosis'.tr(),
              child: Text(diagnosis, style: textStyle),
            ),
          ],
          if (details.bloodPressure.isNotEmpty ||
              details.temperature.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.vitals'.tr(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (details.bloodPressure.isNotEmpty)
                    Text(
                      '${'records.details.bloodPressure'.tr()}: ${details.bloodPressure}',
                      style: textStyle,
                    ),
                  if (details.bloodPressure.isNotEmpty &&
                      details.temperature.isNotEmpty)
                    const SizedBox(height: 8),
                  if (details.temperature.isNotEmpty)
                    Text(
                      '${'records.details.temperature'.tr()}: ${details.temperature}',
                      style: textStyle,
                    ),
                ],
              ),
            ),
          ],
          if (details.medicalNotesAr.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.notes'.tr(),
              child: Text(details.medicalNotesAr, style: textStyle),
            ),
          ],
          if (details.followUpAr.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.followUp'.tr(),
              child: Text(details.followUpAr, style: textStyle),
            ),
          ],
          if (details.requestedTests.isNotEmpty) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.tests'.tr(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final test in details.requestedTests)
                    if (test.titleAr.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(test.titleAr, style: textStyle),
                      ),
                ],
              ),
            ),
          ],
          if (details.prescriptionsCount > 0) ...[
            const SizedBox(height: 16),
            PrescriptionSection(
              title: 'records.details.prescriptions'.tr(),
              child: Text(
                'records.details.prescriptionsCount'.tr(
                  namedArgs: {'count': '${details.prescriptionsCount}'},
                ),
                style: textStyle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
