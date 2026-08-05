import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/profile/domain/entities/doctor_profile_entity.dart';

class DoctorProfileState extends Equatable {
  final BaseState<DoctorProfileEntity> profileState;

  const DoctorProfileState({
    this.profileState = const BaseState(requestState: RequestState.init),
  });

  DoctorProfileState copyWith({
    BaseState<DoctorProfileEntity>? profileState,
  }) {
    return DoctorProfileState(
      profileState: profileState ?? this.profileState,
    );
  }

  @override
  List<Object?> get props => [profileState];
}
