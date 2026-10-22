import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_slot_entity.dart';

class ScheduleDisplay {
  ScheduleDisplay._();

  static const dayKeys = [
    'schedule.days.sunday',
    'schedule.days.monday',
    'schedule.days.tuesday',
    'schedule.days.wednesday',
    'schedule.days.thursday',
    'schedule.days.friday',
    'schedule.days.saturday',
  ];

  static const durations = [15, 30, 45, 60];

  static String dayKey(int dayOfWeek) {
    if (dayOfWeek < 0 || dayOfWeek > 6) return dayKeys[0];
    return dayKeys[dayOfWeek];
  }

  static String slotsSummary(List<ScheduleSlotEntity> slots) {
    if (slots.isEmpty) return '';
    return slots
        .map((s) => '${s.startTime}–${s.endTime}')
        .join(', ');
  }

  static ScheduleDayEntity? findDay(
    List<ScheduleDayEntity> days,
    int dayOfWeek,
  ) {
    for (final day in days) {
      if (day.dayOfWeek == dayOfWeek) return day;
    }
    return null;
  }

  static int timeToMinutes(String time) {
    final parts = time.split(':');
    if (parts.length < 2) return 0;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return hour * 60 + minute;
  }

  static String formatTimeOfDay(int hour, int minute) {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static bool hasOverlap(List<ScheduleSlotEntity> slots) {
    final sorted = [...slots]
      ..sort(
        (a, b) => timeToMinutes(a.startTime).compareTo(
          timeToMinutes(b.startTime),
        ),
      );
    for (var i = 1; i < sorted.length; i++) {
      if (timeToMinutes(sorted[i].startTime) <
          timeToMinutes(sorted[i - 1].endTime)) {
        return true;
      }
    }
    return false;
  }

  static bool isValidWindow(ScheduleSlotEntity slot) {
    return timeToMinutes(slot.startTime) < timeToMinutes(slot.endTime);
  }

  /// Returns an i18n key when invalid, otherwise null.
  static String? validateDaySlots({
    required bool isActive,
    required List<ScheduleSlotEntity> slots,
  }) {
    if (!isActive) return null;
    if (slots.isEmpty) return 'schedule.validation.needWindow';
    for (final slot in slots) {
      if (!isValidWindow(slot)) return 'schedule.validation.invalidWindow';
    }
    if (hasOverlap(slots)) return 'schedule.validation.overlap';
    return null;
  }
}
