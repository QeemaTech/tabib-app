import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/appointment_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/availability_slot_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_availability_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_details_entity.dart';

class DoctorDetailsState extends Equatable {
  final BaseState<DoctorDetailsEntity> doctorDetailsState;
  final BaseState<DoctorAvailabilityEntity> availabilityState;
  final BaseState<AppointmentEntity> bookAppointmentState;
  final DateTime selectedDate;
  final AvailabilitySlotEntity? selectedSlot;
  final String? consultationType;

  DoctorDetailsState({
    this.doctorDetailsState =
        const BaseState(requestState: RequestState.init),
    this.availabilityState =
        const BaseState(requestState: RequestState.init),
    this.bookAppointmentState =
        const BaseState(requestState: RequestState.init),
    DateTime? selectedDate,
    this.selectedSlot,
    this.consultationType = 'CHAT',
  }) : selectedDate = selectedDate ??
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            );

  DoctorDetailsState copyWith({
    BaseState<DoctorDetailsEntity>? doctorDetailsState,
    BaseState<DoctorAvailabilityEntity>? availabilityState,
    BaseState<AppointmentEntity>? bookAppointmentState,
    DateTime? selectedDate,
    AvailabilitySlotEntity? selectedSlot,
    bool clearSelectedSlot = false,
    String? consultationType,
  }) {
    return DoctorDetailsState(
      doctorDetailsState: doctorDetailsState ?? this.doctorDetailsState,
      availabilityState: availabilityState ?? this.availabilityState,
      bookAppointmentState:
          bookAppointmentState ?? this.bookAppointmentState,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSlot:
          clearSelectedSlot ? null : (selectedSlot ?? this.selectedSlot),
      consultationType: consultationType ?? this.consultationType,
    );
  }

  @override
  List<Object?> get props => [
        doctorDetailsState,
        availabilityState,
        bookAppointmentState,
        selectedDate,
        selectedSlot,
        consultationType,
      ];
}
