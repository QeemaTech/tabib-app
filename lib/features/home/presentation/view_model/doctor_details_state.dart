import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';

class DoctorDetailsState extends Equatable {
  final BaseState<DoctorDetailsEntity> doctorDetailsState;

  const DoctorDetailsState({
    this.doctorDetailsState =
        const BaseState(requestState: RequestState.init),
  });

  DoctorDetailsState copyWith({
    BaseState<DoctorDetailsEntity>? doctorDetailsState,
  }) {
    return DoctorDetailsState(
      doctorDetailsState: doctorDetailsState ?? this.doctorDetailsState,
    );
  }

  @override
  List<Object?> get props => [doctorDetailsState];
}
