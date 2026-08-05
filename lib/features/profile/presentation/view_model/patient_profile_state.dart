import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';

class PatientProfileState extends Equatable {
  final BaseState<PatientProfileEntity> profileState;
  final BaseState<PatientProfileEntity> updateProfileState;

  const PatientProfileState({
    this.profileState = const BaseState(requestState: RequestState.init),
    this.updateProfileState = const BaseState(requestState: RequestState.init),
  });

  PatientProfileState copyWith({
    BaseState<PatientProfileEntity>? profileState,
    BaseState<PatientProfileEntity>? updateProfileState,
  }) {
    return PatientProfileState(
      profileState: profileState ?? this.profileState,
      updateProfileState: updateProfileState ?? this.updateProfileState,
    );
  }

  @override
  List<Object?> get props => [profileState, updateProfileState];
}
