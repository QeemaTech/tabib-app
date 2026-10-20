import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/features/appointments/presentation/utils/appointment_ui_helpers.dart'
    show formatAppointmentTimeRange;
import 'package:tabib_app/features/patients/presentation/widgets/appointment_info_details.dart';
import 'package:tabib_app/features/patients/presentation/widgets/expandable_section.dart';
import 'package:tabib_app/features/patients/presentation/widgets/medical_note_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_details.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/presentation/widgets/doctor_booking_visit_section.dart';

class AppointmentDetailsContent extends StatelessWidget {
  final DoctorAppointmentEntity appointment;

  const AppointmentDetailsContent({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final patient = appointment.patient;
    final dateParts = formatAppointmentDate(appointment.date, languageCode);
    final noteTexts = _symptomNotes(appointment);

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
          DoctorBookingVisitSection(appointment: appointment),
          const SizedBox(height: 16),
          ExpandableSection(
            title: 'patients.appointmentDetails.patientInfo'.tr(),
            backgroundColor: const Color(0xFFE9EBF1),
            iconPath: AssetsManager.patientsActive,
            child: PatientInfoDetails(
              gender: _genderLabel(patient.gender),
              height: _heightLabel(patient.heightCm),
              weight: _weightLabel(patient.weightKg),
              phone: [
                if (patient.countryCode.isNotEmpty) patient.countryCode,
                if (patient.phone.isNotEmpty) patient.phone,
              ].join(' '),
            ),
          ),
          ExpandableSection(
            title: 'patients.appointmentDetails.appointmentTime'.tr(),
            backgroundColor: const Color(0xFFE9EBF1),
            iconPath: AssetsManager.appointmentsActive,
            child: AppointmentInfoDetails(
              date: dateParts.dateLabel,
              time: formatAppointmentTimeRange(
                startTime: appointment.startTime,
                endTime: appointment.endTime,
              ),
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
                if (noteTexts.isEmpty)
                  MedicalNoteCard(
                    note: '—',
                    date: dateParts.noteDateLabel,
                  )
                else
                  ...noteTexts.map(
                    (note) => MedicalNoteCard(
                      note: note,
                      date: dateParts.noteDateLabel,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _genderLabel(String gender) {
  switch (gender.toUpperCase()) {
    case 'MALE':
      return 'profile.male'.tr();
    case 'FEMALE':
      return 'profile.female'.tr();
    default:
      return gender.isEmpty ? '—' : gender;
  }
}

String _heightLabel(double? heightCm) {
  if (heightCm == null) return '—';
  return '${heightCm.toStringAsFixed(heightCm % 1 == 0 ? 0 : 1)} ${'patients.details.cm'.tr()}';
}

String _weightLabel(double? weightKg) {
  if (weightKg == null) return '—';
  return '${weightKg.toStringAsFixed(weightKg % 1 == 0 ? 0 : 1)} ${'patients.details.kg'.tr()}';
}

List<String> _symptomNotes(DoctorAppointmentEntity appointment) {
  final values = <String>[
    appointment.complaint.trim(),
    appointment.symptoms.trim(),
    appointment.notes.trim(),
    appointment.patient.medicalComplaint.trim(),
    appointment.patient.medicalSymptoms.trim(),
  ];
  final unique = <String>{};
  for (final value in values) {
    if (value.isNotEmpty) unique.add(value);
  }
  return unique.toList();
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
  // Appointment `date` is a calendar day — keep UTC components to avoid day shift.
  final dateOnly = DateTime.utc(parsed.year, parsed.month, parsed.day);
  final locale = languageCode.startsWith('ar') ? 'ar' : 'en';
  final dayName = DateFormat.EEEE(locale).format(dateOnly);
  final monthName = DateFormat.MMM(locale).format(dateOnly);
  final dayNumber = DateFormat.d(locale).format(dateOnly);
  final dateLabel = DateFormat.yMMMMd(locale).format(dateOnly);
  final noteDateLabel =
      '${DateFormat.yMMMd(locale).format(dateOnly)} • ${DateFormat.EEEE(locale).format(dateOnly)}';
  return AppointmentDateParts(
    dateLabel: dateLabel,
    dayName: dayName,
    monthName: monthName,
    dayNumber: dayNumber,
    noteDateLabel: noteDateLabel,
  );
}
