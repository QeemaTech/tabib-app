import 'package:tabib_app/features/schedule/data/models/response/doctor_schedule_response.dart';
import 'package:tabib_app/features/schedule/data/models/response/schedule_preview_response.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_preview_entity.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_slot_entity.dart';

extension DoctorScheduleResponseMapper on DoctorScheduleResponse {
  List<ScheduleDayEntity> toEntity() {
    return (data ?? const [])
        .map((day) => day.toEntity())
        .toList(growable: false);
  }
}

extension ScheduleDayResponseMapper on ScheduleDayResponse {
  ScheduleDayEntity toEntity() {
    return ScheduleDayEntity(
      dayOfWeek: dayOfWeek ?? 0,
      isActive: isActive ?? false,
      slots: (slots ?? const [])
          .map((slot) => slot.toEntity())
          .toList(growable: false),
    );
  }
}

extension ScheduleSlotResponseMapper on ScheduleSlotResponse {
  ScheduleSlotEntity toEntity() {
    return ScheduleSlotEntity(
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      slotDurationMin: slotDurationMin ?? 30,
    );
  }
}

extension SchedulePreviewResponseMapper on SchedulePreviewResponse {
  SchedulePreviewEntity toEntity() {
    final preview = data;
    return SchedulePreviewEntity(
      date: preview?.date ?? '',
      dayOfWeek: preview?.dayOfWeek ?? 0,
      slots: (preview?.slots ?? const [])
          .map((slot) => slot.toEntity())
          .toList(growable: false),
    );
  }
}

extension SchedulePreviewSlotResponseMapper on SchedulePreviewSlotResponse {
  ScheduleSlotEntity toEntity() {
    return ScheduleSlotEntity(
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      slotDurationMin: slotDurationMin ?? 30,
    );
  }
}
