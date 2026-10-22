import 'package:easy_localization/easy_localization.dart';

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
