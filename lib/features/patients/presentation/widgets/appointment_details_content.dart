import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/features/patients/presentation/widgets/appointment_info_details.dart';
import 'package:tabib_app/features/patients/presentation/widgets/expandable_section.dart';
import 'package:tabib_app/features/patients/presentation/widgets/medical_note_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_details.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';

class AppointmentDetailsContent extends StatelessWidget {
  final DoctorAppointmentEntity appointment;

  const AppointmentDetailsContent({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final patient = appointment.patient;
    final dateParts = formatAppointmentDate(appointment.date, languageCode);
    final notes = appointment.notes.trim();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          PatientInfoCard(
            name: patient.localizedFullName(languageCode),
            id: patient.id,
            imagePath: patient.hasAvatar ? patient.avatarUrl : null,
          ),
          const SizedBox(height: 16),
          ExpandableSection(
            title: 'patients.appointmentDetails.patientInfo'.tr(),
            backgroundColor: const Color(0xFFE9EBF1),
            iconPath: AssetsManager.patientsActive,
            child: const PatientInfoDetails(
              gender: '—',
              birthDate: '—',
              height: '—',
              weight: '—',
            ),
          ),
          ExpandableSection(
            title: 'patients.appointmentDetails.appointmentTime'.tr(),
            backgroundColor: const Color(0xFFE9EBF1),
            iconPath: AssetsManager.appointmentsActive,
            child: AppointmentInfoDetails(
              date: dateParts.dateLabel,
              time: appointment.startTime,
              day: dateParts.dayName,
              month: dateParts.monthName,
              dayNumber: dateParts.dayNumber,
            ),
          ),
          ExpandableSection(
            title: 'patients.appointmentDetails.symptoms'.tr(),
            isExpanded: true,
            backgroundColor: const Color(0xFFFEF9F0),
            iconPath: AssetsManager.document,
            child: Column(
              children: [
                if (notes.isNotEmpty)
                  MedicalNoteCard(
                    note: notes,
                    date: dateParts.noteDateLabel,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentDateParts {
  final String dateLabel;
  final String dayName;
  final String monthName;
  final String dayNumber;
  final String noteDateLabel;

  const AppointmentDateParts({
    required this.dateLabel,
    required this.dayName,
    required this.monthName,
    required this.dayNumber,
    required this.noteDateLabel,
  });
}

AppointmentDateParts formatAppointmentDate(
  String rawDate,
  String languageCode,
) {
  final parsed = DateTime.tryParse(rawDate);
  if (parsed == null) {
    return const AppointmentDateParts(
      dateLabel: '',
      dayName: '',
      monthName: '',
      dayNumber: '',
      noteDateLabel: '',
    );
  }
  final locale = languageCode.startsWith('ar') ? 'ar' : 'en';
  final dayName = DateFormat.EEEE(locale).format(parsed);
  final monthName = DateFormat.MMM(locale).format(parsed);
  final dayNumber = DateFormat.d(locale).format(parsed);
  final dateLabel = DateFormat.yMMMMd(locale).format(parsed);
  final noteDateLabel =
      '${DateFormat.yMMMd(locale).format(parsed)} • ${DateFormat.EEEE(locale).format(parsed)}';
  return AppointmentDateParts(
    dateLabel: dateLabel,
    dayName: dayName,
    monthName: monthName,
    dayNumber: dayNumber,
    noteDateLabel: noteDateLabel,
  );
}
