import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patients/domain/entities/doctor_patient_entity.dart';

class DoctorPatientsState extends Equatable {
  final String searchQuery;
  final String filter;
  final BaseState<List<DoctorPatientEntity>> patientsState;

  const DoctorPatientsState({
    this.searchQuery = '',
    this.filter = 'all',
    this.patientsState = const BaseState(requestState: RequestState.init),
  });

  DoctorPatientsState copyWith({
    String? searchQuery,
    String? filter,
    BaseState<List<DoctorPatientEntity>>? patientsState,
  }) {
    return DoctorPatientsState(
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
      patientsState: patientsState ?? this.patientsState,
    );
  }

  @override
  List<Object?> get props => [searchQuery, filter, patientsState];
}
