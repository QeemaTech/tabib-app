import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_slot_entity.dart';

class SchedulePreviewEntity extends Equatable {
  final String date;
  final int dayOfWeek;
  final List<ScheduleSlotEntity> slots;

  const SchedulePreviewEntity({
    required this.date,
    required this.dayOfWeek,
    required this.slots,
  });

  @override
  List<Object?> get props => [date, dayOfWeek, slots];
}
