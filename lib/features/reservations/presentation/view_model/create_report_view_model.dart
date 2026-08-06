import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/reservations/data/models/request/create_doctor_report_request.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_report_entity.dart';
import 'package:tabib_app/features/reservations/domain/repo/doctor_appointments_repo.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/create_report_state.dart';

@injectable
class CreateReportViewModel extends Cubit<CreateReportState> {
  final DoctorAppointmentsRepo doctorAppointmentsRepo;
  String _appointmentId = '';

  CreateReportViewModel({required this.doctorAppointmentsRepo})
      : super(const CreateReportState());

  Future<void> loadDetails(String appointmentId) async {
    _appointmentId = appointmentId;
    if (appointmentId.trim().isEmpty) {
      emit(
        state.copyWith(
          detailsState: BaseState.error('errors.unknown'.tr()),
        ),
      );
      return;
    }

    emit(state.copyWith(detailsState: BaseState.loading()));

    final result =
        await doctorAppointmentsRepo.getAppointmentDetails(appointmentId);

    switch (result) {
      case Success<DoctorAppointmentEntity>():
        emit(state.copyWith(detailsState: BaseState.loaded(result.data)));
      case Failure<DoctorAppointmentEntity>():
        emit(
          state.copyWith(
            detailsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => loadDetails(_appointmentId);

  Future<void> submit({
    required String visitTypeAr,
    required String bloodPressure,
    required String temperature,
    required String diagnosis,
    required String drugNameAr,
    required String dosage,
    required String frequency,
    required String duration,
    required String requiredTestsText,
    required String followUpAr,
    required String medicalNotesAr,
  }) async {
    if (_appointmentId.trim().isEmpty) {
      emit(
        state.copyWith(
          submitState: BaseState.error('errors.unknown'.tr()),
        ),
      );
      return;
    }

    emit(state.copyWith(submitState: BaseState.loading()));

    final tests = requiredTestsText
        .split(RegExp(r'[\n,]'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    final request = CreateDoctorReportRequest(
      visitTypeAr: visitTypeAr.trim(),
      bloodPressure: bloodPressure.trim(),
      temperature: temperature.trim(),
      diagnosis: diagnosis.trim(),
      medications: [
        CreateDoctorReportMedicationRequest(
          drugNameAr: drugNameAr.trim(),
          dosage: dosage.trim(),
          frequency: frequency.trim(),
          duration: duration.trim(),
        ),
      ],
      requiredTests: tests.isEmpty && requiredTestsText.trim().isNotEmpty
          ? [requiredTestsText.trim()]
          : tests,
      followUpAr: followUpAr.trim(),
      medicalNotesAr: medicalNotesAr.trim(),
    );

    final result =
        await doctorAppointmentsRepo.createReport(_appointmentId, request);

    switch (result) {
      case Success<DoctorReportEntity>():
        emit(state.copyWith(submitState: BaseState.loaded(result.data)));
      case Failure<DoctorReportEntity>():
        emit(
          state.copyWith(
            submitState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
