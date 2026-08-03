import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/home/domain/entities/patient_home_entity.dart';

class PatientHomeState extends Equatable {
  final BaseState<PatientHomeEntity> homeState;

  const PatientHomeState({
    this.homeState = const BaseState(requestState: RequestState.init),
  });

  PatientHomeState copyWith({
    BaseState<PatientHomeEntity>? homeState,
  }) {
    return PatientHomeState(
      homeState: homeState ?? this.homeState,
    );
  }

  @override
  List<Object?> get props => [homeState];
}
