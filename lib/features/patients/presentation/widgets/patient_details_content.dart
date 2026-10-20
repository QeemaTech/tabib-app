import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/presentation/utils/appointment_ui_helpers.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_card_facts.dart';
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
    final appointment = file.appointment;
    final theme = context.appTheme;
    final notes = patientFileDisplay(appointment.notes);
    final gender = _genderLabel(patient.gender);
    final phone = patient.phone.trim();
    final showPatientInfo = _hasProfileValue(gender) || _hasProfileValue(phone);
    final feeText = appointment.currency.isEmpty
        ? '${appointment.bookingPrice}'
        : '${appointment.bookingPrice} ${appointment.currency}';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          PatientInfoCard(
            name: patientFileDisplay(patient.fullNameAr),
            id: patientFileDisplay(patient.id),
          ),
          const SizedBox(height: 24),
          if (showPatientInfo) ...[
            ExpandableSection(
              title: 'patients.details.patientInfo'.tr(),
              backgroundColor: const Color(0xFFE9EBF1),
              iconPath: AssetsManager.patientsActive,
              child: PatientInfoDetails(
                gender: gender,
                phone: phone,
              ),
            ),
            const SizedBox(height: 12),
          ],
          AppointmentCardFacts(
            consultationType: appointment.consultationType,
            consultationTypeLabel: consultationTypeLabel(
              appointment.consultationType,
            ),
            dateText: formatAppointmentDate(appointment.date),
            timeText: formatAppointmentTimeRange(
              startTime: appointment.startTime,
              endTime: appointment.endTime,
            ),
            durationText: '',
            feeText: feeText,
            notes: notes == '----' ? '' : notes,
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
          if (notes.isNotEmpty && notes != '----')
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
                  notes,
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

  bool _hasProfileValue(String value) {
    final trimmed = value.trim();
    return trimmed.isNotEmpty && trimmed != '—' && trimmed != '----';
  }
}
