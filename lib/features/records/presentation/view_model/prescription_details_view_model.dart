import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/records/domain/entities/patient_prescription_details_entity.dart';
import 'package:tabib_app/features/records/domain/repo/records_repo.dart';
import 'package:tabib_app/features/records/presentation/view_model/prescription_details_state.dart';

@injectable
class PrescriptionDetailsViewModel extends Cubit<PrescriptionDetailsState> {
  final RecordsRepo recordsRepo;

  PrescriptionDetailsViewModel({required this.recordsRepo})
    : super(const PrescriptionDetailsState());

  Future<void> load(String id) async {
    final prescriptionId = id.trim();
    emit(state.copyWith(detailsState: BaseState.loading()));
    final result = await recordsRepo.getPrescriptionDetails(prescriptionId);
    switch (result) {
      case Success<PatientPrescriptionDetailsEntity>():
        emit(state.copyWith(detailsState: BaseState.loaded(result.data)));
      case Failure<PatientPrescriptionDetailsEntity>():
        emit(
          state.copyWith(detailsState: BaseState.error(result.errorMessage)),
        );
    }
  }
}
