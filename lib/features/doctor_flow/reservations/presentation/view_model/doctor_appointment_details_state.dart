import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';

class DoctorAppointmentDetailsState extends Equatable {
  final BaseState<DoctorAppointmentEntity> detailsState;

  const DoctorAppointmentDetailsState({
    this.detailsState = const BaseState(requestState: RequestState.init),
  });

  DoctorAppointmentDetailsState copyWith({
    BaseState<DoctorAppointmentEntity>? detailsState,
  }) {
    return DoctorAppointmentDetailsState(
      detailsState: detailsState ?? this.detailsState,
    );
  }

  @override
  List<Object?> get props => [detailsState];
}
