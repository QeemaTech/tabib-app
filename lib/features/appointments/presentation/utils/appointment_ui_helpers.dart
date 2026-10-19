import 'package:easy_localization/easy_localization.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';

String appointmentStatusLabel(String status) {
  switch (status.toUpperCase()) {
    case 'CONFIRMED':
      return 'appointments.statusConfirmed'.tr();
    case 'IN_PROGRESS':
      return 'appointments.statusInProgress'.tr();
    case 'COMPLETED':
      return 'appointments.statusCompleted'.tr();
    case 'PENDING':
      return 'appointments.statusPending'.tr();
    case 'CANCELLED':
      return 'appointments.statusCancelled'.tr();
    default:
      return status;
  }
}

String formatAppointmentDateTime(PatientAppointmentEntity appointment) {
  final rawDate = appointment.date;
  final datePart =
      rawDate.contains('T') ? rawDate.split('T').first : rawDate;
  return '$datePart | ${appointment.startTime}';
}

String formatAppointmentDetailsWhen(PatientAppointmentDetailsEntity details) {
  final rawDate = details.date;
  final datePart = rawDate.contains('T') ? rawDate.split('T').first : rawDate;
  final start = details.startTime;
  final end = details.endTime;
  final time = end.isEmpty || end == start ? start : '$start - $end';
  if (datePart.isEmpty) return time;
  if (time.isEmpty) return datePart;
  return '$datePart | $time';
}

bool isAppointmentPaid(PatientAppointmentActionsEntity actions) {
  return !actions.canPay;
}
