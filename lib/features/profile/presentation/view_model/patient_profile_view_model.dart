import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/profile/domain/repo/patient_profile_repo.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_state.dart';

@injectable
class PatientProfileViewModel extends Cubit<PatientProfileState> {
  final PatientProfileRepo patientProfileRepo;

  PatientProfileViewModel({required this.patientProfileRepo})
      : super(const PatientProfileState());

  Future<void> loadProfile({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(profileState: BaseState.loading()));
    }
    final result = await patientProfileRepo.getPatientProfile();
    switch (result) {
      case Success<PatientProfileEntity>():
        emit(state.copyWith(profileState: BaseState.loaded(result.data)));
      case Failure<PatientProfileEntity>():
        emit(
          state.copyWith(
            profileState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => loadProfile();

  Future<void> refreshProfile() => loadProfile(showLoading: false);
}
