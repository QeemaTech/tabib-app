import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/home/domain/entities/availability_slot_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_availability_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';

class DoctorDetailsState extends Equatable {
  final BaseState<DoctorDetailsEntity> doctorDetailsState;
  final BaseState<DoctorAvailabilityEntity> availabilityState;
  final DateTime selectedDate;
  final AvailabilitySlotEntity? selectedSlot;

  DoctorDetailsState({
    this.doctorDetailsState =
        const BaseState(requestState: RequestState.init),
    this.availabilityState =
        const BaseState(requestState: RequestState.init),
    DateTime? selectedDate,
    this.selectedSlot,
  }) : selectedDate = selectedDate ??
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            );

  DoctorDetailsState copyWith({
    BaseState<DoctorDetailsEntity>? doctorDetailsState,
    BaseState<DoctorAvailabilityEntity>? availabilityState,
    DateTime? selectedDate,
    AvailabilitySlotEntity? selectedSlot,
    bool clearSelectedSlot = false,
  }) {
    return DoctorDetailsState(
      doctorDetailsState: doctorDetailsState ?? this.doctorDetailsState,
      availabilityState: availabilityState ?? this.availabilityState,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSlot:
          clearSelectedSlot ? null : (selectedSlot ?? this.selectedSlot),
    );
  }

  @override
  List<Object?> get props => [
        doctorDetailsState,
        availabilityState,
        selectedDate,
        selectedSlot,
      ];
}
