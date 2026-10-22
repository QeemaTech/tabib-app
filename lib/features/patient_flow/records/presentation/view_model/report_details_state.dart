import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_report_details_entity.dart';

class ReportDetailsState extends Equatable {
  final BaseState<PatientReportDetailsEntity> detailsState;

  const ReportDetailsState({
    this.detailsState = const BaseState(requestState: RequestState.init),
  });

  ReportDetailsState copyWith({
    BaseState<PatientReportDetailsEntity>? detailsState,
  }) {
    return ReportDetailsState(detailsState: detailsState ?? this.detailsState);
  }

  @override
  List<Object?> get props => [detailsState];
}
