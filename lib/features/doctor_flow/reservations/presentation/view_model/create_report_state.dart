import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_report_entity.dart';

class CreateReportState extends Equatable {
  final BaseState<DoctorAppointmentEntity> detailsState;
  final BaseState<DoctorReportEntity> submitState;

  const CreateReportState({
    this.detailsState = const BaseState(requestState: RequestState.init),
    this.submitState = const BaseState(requestState: RequestState.init),
  });

  CreateReportState copyWith({
    BaseState<DoctorAppointmentEntity>? detailsState,
    BaseState<DoctorReportEntity>? submitState,
  }) {
    return CreateReportState(
      detailsState: detailsState ?? this.detailsState,
      submitState: submitState ?? this.submitState,
    );
  }

  @override
  List<Object?> get props => [detailsState, submitState];
}
