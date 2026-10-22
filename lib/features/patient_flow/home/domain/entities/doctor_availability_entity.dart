import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/availability_slot_entity.dart';

class DoctorAvailabilityEntity extends Equatable {
  final String date;
  final List<AvailabilitySlotEntity> slots;

  const DoctorAvailabilityEntity({
    required this.date,
    required this.slots,
  });

  @override
  List<Object?> get props => [date, slots];
}
