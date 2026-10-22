import 'package:equatable/equatable.dart';

class AvailabilitySlotEntity extends Equatable {
  final String startTime;
  final String endTime;
  final bool available;

  const AvailabilitySlotEntity({
    required this.startTime,
    required this.endTime,
    required this.available,
  });

  @override
  List<Object?> get props => [startTime, endTime, available];
}
