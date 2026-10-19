import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_details_entity.dart';

class AppointmentDetailsState extends Equatable {
  final BaseState<PatientAppointmentDetailsEntity> detailsState;

  const AppointmentDetailsState({
    this.detailsState = const BaseState(requestState: RequestState.init),
  });

  AppointmentDetailsState copyWith({
    BaseState<PatientAppointmentDetailsEntity>? detailsState,
  }) {
    return AppointmentDetailsState(
      detailsState: detailsState ?? this.detailsState,
    );
  }

  @override
  List<Object?> get props => [detailsState];
}
