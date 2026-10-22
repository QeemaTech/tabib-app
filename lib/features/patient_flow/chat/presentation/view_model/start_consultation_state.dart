import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/chat/domain/entities/started_consultation_entity.dart';

class StartConsultationState extends Equatable {
  final BaseState<StartedConsultationEntity> startState;
  final String? appointmentId;

  const StartConsultationState({
    this.startState = const BaseState(requestState: RequestState.init),
    this.appointmentId,
  });

  StartConsultationState copyWith({
    BaseState<StartedConsultationEntity>? startState,
    String? appointmentId,
  }) {
    return StartConsultationState(
      startState: startState ?? this.startState,
      appointmentId: appointmentId ?? this.appointmentId,
    );
  }

  @override
  List<Object?> get props => [startState, appointmentId];
}
