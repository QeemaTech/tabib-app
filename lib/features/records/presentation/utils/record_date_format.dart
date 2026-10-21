import 'package:tabib_app/features/appointments/presentation/utils/appointment_ui_helpers.dart';

class RecordDateParts {
  final String date;
  final String time;

  const RecordDateParts({required this.date, required this.time});
}

RecordDateParts formatRecordTimestamp(String iso) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) {
    return RecordDateParts(date: formatAppointmentDate(iso), time: '');
  }
  final local = parsed.toLocal();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return RecordDateParts(
    date: formatAppointmentDate(iso),
    time: '$hour:$minute',
  );
}
