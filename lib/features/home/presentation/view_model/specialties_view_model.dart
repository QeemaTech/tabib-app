import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:tabib_app/features/auth/domain/repo/doctor_onboarding_repo.dart';
import 'package:tabib_app/features/home/presentation/view_model/specialties_state.dart';

@injectable
class SpecialtiesViewModel extends Cubit<SpecialtiesState> {
  final DoctorOnboardingRepo doctorOnboardingRepo;

  SpecialtiesViewModel({required this.doctorOnboardingRepo})
      : super(const SpecialtiesState());

  Future<void> loadSpecialties() async {
    emit(state.copyWith(specialtiesState: BaseState.loading()));
    final result = await doctorOnboardingRepo.getSpecialties();
    switch (result) {
      case Success<List<SpecialtyEntity>>():
        emit(
          state.copyWith(
            specialtiesState: BaseState.loaded(result.data),
          ),
        );
      case Failure<List<SpecialtyEntity>>():
        emit(
          state.copyWith(
            specialtiesState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(query: query));
  }

  Future<void> retry() => loadSpecialties();
}
