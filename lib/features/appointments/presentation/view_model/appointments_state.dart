import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';

class AppointmentsState extends Equatable {
  final BaseState<List<PatientAppointmentEntity>> appointmentsState;
  final BaseState<PatientAppointmentEntity> cancelAppointmentState;

  const AppointmentsState({
    this.appointmentsState =
        const BaseState(requestState: RequestState.init),
    this.cancelAppointmentState =
        const BaseState(requestState: RequestState.init),
  });

  AppointmentsState copyWith({
    BaseState<List<PatientAppointmentEntity>>? appointmentsState,
    BaseState<PatientAppointmentEntity>? cancelAppointmentState,
  }) {
    return AppointmentsState(
      appointmentsState: appointmentsState ?? this.appointmentsState,
      cancelAppointmentState:
          cancelAppointmentState ?? this.cancelAppointmentState,
    );
  }

  @override
  List<Object?> get props => [appointmentsState, cancelAppointmentState];
}
