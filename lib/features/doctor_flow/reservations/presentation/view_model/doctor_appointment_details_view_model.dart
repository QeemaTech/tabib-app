import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/repo/doctor_appointments_repo.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/doctor_appointment_details_state.dart';

@injectable
class DoctorAppointmentDetailsViewModel
    extends Cubit<DoctorAppointmentDetailsState> {
  final DoctorAppointmentsRepo doctorAppointmentsRepo;

  DoctorAppointmentDetailsViewModel({required this.doctorAppointmentsRepo})
      : super(const DoctorAppointmentDetailsState());

  Future<void> loadDetails(String appointmentId) async {
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

  Future<void> retry(String appointmentId) => loadDetails(appointmentId);
}
