import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/patients/domain/entities/patient_file_entity.dart';
import 'package:tabib_app/features/doctor_flow/patients/domain/repo/patient_file_repo.dart';
import 'package:tabib_app/features/doctor_flow/patients/presentation/view_model/patient_file_state.dart';

@injectable
class PatientFileViewModel extends Cubit<PatientFileState> {
  final PatientFileRepo patientFileRepo;
  String _appointmentId = '';

  PatientFileViewModel({required this.patientFileRepo})
      : super(const PatientFileState());

  Future<void> load(String appointmentId) async {
    _appointmentId = appointmentId;
    if (appointmentId.trim().isEmpty) {
      emit(
        state.copyWith(
          fileState: BaseState.error('errors.unknown'.tr()),
        ),
      );
      return;
    }

    emit(state.copyWith(fileState: BaseState.loading()));

    final result = await patientFileRepo.getPatientFile(appointmentId);

    switch (result) {
      case Success<PatientFileEntity>():
        emit(state.copyWith(fileState: BaseState.loaded(result.data)));
      case Failure<PatientFileEntity>():
        emit(
          state.copyWith(
            fileState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => load(_appointmentId);
}
