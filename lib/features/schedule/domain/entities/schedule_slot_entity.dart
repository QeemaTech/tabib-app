import 'package:equatable/equatable.dart';

class ScheduleSlotEntity extends Equatable {
  final String startTime;
  final String endTime;
  final int slotDurationMin;

  const ScheduleSlotEntity({
    required this.startTime,
    required this.endTime,
    required this.slotDurationMin,
  });

  @override
  List<Object?> get props => [startTime, endTime, slotDurationMin];
}
