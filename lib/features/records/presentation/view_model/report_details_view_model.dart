import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/records/domain/entities/patient_report_details_entity.dart';
import 'package:tabib_app/features/records/domain/repo/records_repo.dart';
import 'package:tabib_app/features/records/presentation/view_model/report_details_state.dart';

@injectable
class ReportDetailsViewModel extends Cubit<ReportDetailsState> {
  final RecordsRepo recordsRepo;

  ReportDetailsViewModel({required this.recordsRepo})
    : super(const ReportDetailsState());

  Future<void> load(String id) async {
    final reportId = id.trim();
    emit(state.copyWith(detailsState: BaseState.loading()));
    final result = await recordsRepo.getReportDetails(reportId);
    switch (result) {
      case Success<PatientReportDetailsEntity>():
        emit(state.copyWith(detailsState: BaseState.loaded(result.data)));
      case Failure<PatientReportDetailsEntity>():
        emit(
          state.copyWith(detailsState: BaseState.error(result.errorMessage)),
        );
    }
  }
}
