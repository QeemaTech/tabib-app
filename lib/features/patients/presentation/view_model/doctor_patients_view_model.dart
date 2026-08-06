import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patients/domain/entities/doctor_patient_entity.dart';
import 'package:tabib_app/features/patients/domain/repo/doctor_patients_repo.dart';
import 'package:tabib_app/features/patients/presentation/view_model/doctor_patients_state.dart';

@injectable
class DoctorPatientsViewModel extends Cubit<DoctorPatientsState> {
  final DoctorPatientsRepo doctorPatientsRepo;
  Timer? _debounce;

  DoctorPatientsViewModel({required this.doctorPatientsRepo})
      : super(const DoctorPatientsState());

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), loadPatients);
  }

  void onFilterChanged(String filter) {
    if (state.filter == filter) return;
    emit(state.copyWith(filter: filter));
    loadPatients();
  }

  Future<void> loadPatients({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(patientsState: BaseState.loading()));
    }

    final search = state.searchQuery.trim();
    final result = await doctorPatientsRepo.getPatients(
      search: search.isEmpty ? null : search,
      filter: state.filter,
    );

    switch (result) {
      case Success<List<DoctorPatientEntity>>():
        emit(state.copyWith(patientsState: BaseState.loaded(result.data)));
      case Failure<List<DoctorPatientEntity>>():
        emit(
          state.copyWith(
            patientsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => loadPatients();

  Future<void> refresh() => loadPatients(showLoading: false);

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
