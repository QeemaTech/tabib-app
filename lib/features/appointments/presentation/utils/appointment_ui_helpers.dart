import 'package:easy_localization/easy_localization.dart';
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

bool canCancelAppointment(String status) {
  final value = status.toUpperCase();
  return value == 'PENDING' || value == 'CONFIRMED';
}
