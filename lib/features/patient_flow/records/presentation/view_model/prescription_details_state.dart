import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_prescription_details_entity.dart';

class PrescriptionDetailsState extends Equatable {
  final BaseState<PatientPrescriptionDetailsEntity> detailsState;

  const PrescriptionDetailsState({
    this.detailsState = const BaseState(requestState: RequestState.init),
  });

  PrescriptionDetailsState copyWith({
    BaseState<PatientPrescriptionDetailsEntity>? detailsState,
  }) {
    return PrescriptionDetailsState(
      detailsState: detailsState ?? this.detailsState,
    );
  }

  @override
  List<Object?> get props => [detailsState];
}
