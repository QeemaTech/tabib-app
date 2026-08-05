import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';

class PatientProfileState extends Equatable {
  final BaseState<PatientProfileEntity> profileState;

  const PatientProfileState({
    this.profileState = const BaseState(requestState: RequestState.init),
  });

  PatientProfileState copyWith({
    BaseState<PatientProfileEntity>? profileState,
  }) {
    return PatientProfileState(
      profileState: profileState ?? this.profileState,
    );
  }

  @override
  List<Object?> get props => [profileState];
}
