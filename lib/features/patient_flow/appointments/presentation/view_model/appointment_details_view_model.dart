import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/repo/appointments_repo.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/appointment_details_state.dart';

@injectable
class AppointmentDetailsViewModel extends Cubit<AppointmentDetailsState> {
  final AppointmentsRepo appointmentsRepo;

  AppointmentDetailsViewModel({required this.appointmentsRepo})
    : super(const AppointmentDetailsState());

  Future<void> loadDetails(String id) async {
    final appointmentId = id.trim();
    emit(state.copyWith(detailsState: BaseState.loading()));
    final result = await appointmentsRepo.getAppointmentDetails(appointmentId);
    switch (result) {
      case Success<PatientAppointmentDetailsEntity>():
        emit(state.copyWith(detailsState: BaseState.loaded(result.data)));
      case Failure<PatientAppointmentDetailsEntity>():
        emit(
          state.copyWith(detailsState: BaseState.error(result.errorMessage)),
        );
    }
  }
}
