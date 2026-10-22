import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/repo/auth_repo.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/entities/doctor_profile_entity.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/repo/doctor_profile_repo.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/view_model/doctor_profile_state.dart';

@injectable
class DoctorProfileViewModel extends Cubit<DoctorProfileState> {
  final DoctorProfileRepo doctorProfileRepo;
  final DoctorAuthRepo authRepo;

  DoctorProfileViewModel({
    required this.doctorProfileRepo,
    required this.authRepo,
  }) : super(const DoctorProfileState());

  Future<void> loadProfile({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(profileState: BaseState.loading()));
    }
    final result = await doctorProfileRepo.getDoctorProfile();
    switch (result) {
      case Success<DoctorProfileEntity>():
        emit(state.copyWith(profileState: BaseState.loaded(result.data)));
      case Failure<DoctorProfileEntity>():
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
    if (SocketIoService.isInitialized) {
      SocketIoService.instance.disconnect();
    }
  }
}
