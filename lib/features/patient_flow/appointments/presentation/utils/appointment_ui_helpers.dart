import 'package:easy_localization/easy_localization.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_entity.dart';

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

String consultationTypeLabel(String type) {
  switch (type.toUpperCase()) {
    case 'CHAT':
      return 'appointments.typeChat'.tr();
    case 'VOICE':
      return 'appointments.typeVoice'.tr();
    case 'VIDEO':
      return 'appointments.typeVideo'.tr();
    default:
      return type;
  }
}

String formatAppointmentDate(String rawDate) {
  if (rawDate.contains('T')) return rawDate.split('T').first;
  return rawDate;
}

String formatAppointmentTimeRange({
  required String startTime,
  required String endTime,
}) {
  if (endTime.isEmpty || endTime == startTime) return startTime;
  return '$startTime - $endTime';
}

String appointmentDurationLabel({
  required String consultationType,
  required int durationChatHours,
  required int durationCallMinutes,
}) {
  final type = consultationType.toUpperCase();
  if (type == 'CHAT' && durationChatHours > 0) {
    return 'appointments.chatDuration'.tr(
      namedArgs: {'hours': '$durationChatHours'},
    );
  }
  if ((type == 'VOICE' || type == 'VIDEO') && durationCallMinutes > 0) {
    return 'appointments.callDuration'.tr(
      namedArgs: {'minutes': '$durationCallMinutes'},
    );
  }
  return '';
}

String formatAppointmentDateTime(PatientAppointmentEntity appointment) {
  final datePart = formatAppointmentDate(appointment.date);
  final time = formatAppointmentTimeRange(
    startTime: appointment.startTime,
    endTime: appointment.endTime,
  );
  if (datePart.isEmpty) return time;
  if (time.isEmpty) return datePart;
  return '$datePart | $time';
}

String formatAppointmentDetailsWhen(PatientAppointmentDetailsEntity details) {
  final datePart = formatAppointmentDate(details.date);
  final time = formatAppointmentTimeRange(
    startTime: details.startTime,
    endTime: details.endTime,
  );
  if (datePart.isEmpty) return time;
  if (time.isEmpty) return datePart;
  return '$datePart | $time';
}

bool isAppointmentPaid(PatientAppointmentActionsEntity actions) {
  return !actions.canPay;
}
