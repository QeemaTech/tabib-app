import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_slot_entity.dart';

class ScheduleDayEntity extends Equatable {
  final int dayOfWeek;
  final bool isActive;
  final List<ScheduleSlotEntity> slots;

  const ScheduleDayEntity({
    required this.dayOfWeek,
    required this.isActive,
    required this.slots,
  });

  @override
  List<Object?> get props => [dayOfWeek, isActive, slots];
}
