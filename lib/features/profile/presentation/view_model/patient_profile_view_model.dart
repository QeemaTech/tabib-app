import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/core/services/socket_io_service.dart';
import 'package:tabib_app/features/auth/domain/repo/auth_repo.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/profile/domain/repo/patient_profile_repo.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_state.dart';

@injectable
class PatientProfileViewModel extends Cubit<PatientProfileState> {
  final PatientProfileRepo patientProfileRepo;
  final AuthRepo authRepo;
  final SocketIoService socketIoService;

  PatientProfileViewModel({
    required this.patientProfileRepo,
    required this.authRepo,
    required this.socketIoService,
  }) : super(const PatientProfileState());

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

  Future<void> logout() async {
    await authRepo.unregisterDevice();
    socketIoService.dispose();
  }

  Future<void> updateProfile({
    required String fullNameAr,
    required String fullNameEn,
    required String fullNameSo,
    required String dateOfBirth,
    required String gender,
    required String bloodType,
    required String allergies,
    required String chronicConditions,
  }) async {
    emit(state.copyWith(updateProfileState: BaseState.loading()));
    final result = await patientProfileRepo.updatePatientProfile(
      fullNameAr: fullNameAr.trim(),
      fullNameEn: fullNameEn.trim(),
      fullNameSo: fullNameSo.trim(),
      dateOfBirth: dateOfBirth,
      gender: gender,
      bloodType: bloodType.trim(),
      allergies: allergies.trim(),
      chronicConditions: chronicConditions.trim(),
    );
    switch (result) {
      case Success<PatientProfileEntity>():
        emit(
          state.copyWith(
            updateProfileState: BaseState.loaded(result.data),
            profileState: BaseState.loaded(result.data),
          ),
        );
      case Failure<PatientProfileEntity>():
        emit(
          state.copyWith(
            updateProfileState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void resetUpdateState() {
    emit(
      state.copyWith(
        updateProfileState: BaseState.init(),
      ),
    );
  }
}
