import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/patient_home_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/repo/patient_home_repo.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/patient_home_state.dart';

@injectable
class PatientHomeViewModel extends Cubit<PatientHomeState> {
  final PatientHomeRepo patientHomeRepo;

  PatientHomeViewModel({required this.patientHomeRepo})
      : super(const PatientHomeState());

  Future<void> loadHome() async {
    emit(state.copyWith(homeState: BaseState.loading()));
    final result = await patientHomeRepo.getPatientHome();
    switch (result) {
      case Success<PatientHomeEntity>():
        emit(
          state.copyWith(
            homeState: BaseState.loaded(result.data),
          ),
        );
      case Failure<PatientHomeEntity>():
        emit(
          state.copyWith(
            homeState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
