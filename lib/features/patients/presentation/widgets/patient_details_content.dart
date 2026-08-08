import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_entity.dart';
import 'package:tabib_app/features/patients/presentation/utils/patient_file_display.dart';
import 'package:tabib_app/features/patients/presentation/widgets/expandable_section.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_file_medical_overview.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_file_visit_history.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_details.dart';

class PatientDetailsContent extends StatelessWidget {
  final PatientFileEntity file;

  const PatientDetailsContent({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final patient = file.patient;
    final theme = context.appTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          PatientInfoCard(
            name: patientFileDisplay(patient.fullNameAr),
            id: patientFileDisplay(patient.id),
          ),
          const SizedBox(height: 24),
          ExpandableSection(
            title: 'patients.details.patientInfo'.tr(),
            backgroundColor: const Color(0xFFE9EBF1),
            iconPath: AssetsManager.patientsActive,
            child: PatientInfoDetails(
              gender: _genderLabel(patient.gender),
              birthDate: '----',
              height: '----',
              weight: '----',
            ),
          ),
          ExpandableSection(
            title: 'patients.details.medicalOverview'.tr(),
            iconPath: AssetsManager.stethoscope,
            backgroundColor: const Color(0xFFE9EBF1),
            child: PatientFileMedicalOverview(
              bloodType: patient.bloodType,
              allergies: patient.allergies,
              chronicConditions: patient.chronicConditions,
            ),
          ),
          ExpandableSection(
            title: 'patients.details.visitHistory'.tr(),
            iconPath: AssetsManager.history,
            backgroundColor: const Color(0xFFE9EBF1),
            child: PatientFileVisitHistory(items: file.medicalHistory),
          ),
          ExpandableSection(
            title: 'patients.details.latestExaminations'.tr(),
            iconPath: AssetsManager.health,
            backgroundColor: const Color(0xFFEAF8F6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF8F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const PatientFileVisitHistoryItem(
                title: '----',
                dateLabel: '----',
              ),
            ),
          ),
          ExpandableSection(
            title: 'patients.details.medicalNotes'.tr(),
            backgroundColor: const Color(0xFFFEF9F0),
            iconPath: AssetsManager.document,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF9F0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                patientFileDisplay(file.appointment.notes),
                textAlign: TextAlign.start,
                style: theme.regular14.copyWith(color: theme.textColor600),
              ),
            ),
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
        return patientFileDisplay(gender);
    }
  }
}
