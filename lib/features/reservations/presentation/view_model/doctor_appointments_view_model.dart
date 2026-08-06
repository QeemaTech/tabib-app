import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/domain/repo/doctor_appointments_repo.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointments_state.dart';

@injectable
class DoctorAppointmentsViewModel extends Cubit<DoctorAppointmentsState> {
  final DoctorAppointmentsRepo doctorAppointmentsRepo;

  DoctorAppointmentsViewModel({required this.doctorAppointmentsRepo})
      : super(const DoctorAppointmentsState());

  void onFilterChanged(DoctorAppointmentsFilter filter) {
    if (state.filter == filter) return;
    emit(state.copyWith(filter: filter));
    loadAppointments();
  }

  Future<void> loadAppointments({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(appointmentsState: BaseState.loading()));
    }

    final result = await doctorAppointmentsRepo.getAppointments(
      status: state.apiStatus,
    );

    switch (result) {
      case Success<List<DoctorAppointmentEntity>>():
        emit(
          state.copyWith(
            appointmentsState: BaseState.loaded(result.data),
          ),
        );
      case Failure<List<DoctorAppointmentEntity>>():
        emit(
          state.copyWith(
            appointmentsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => loadAppointments();

  Future<void> refresh() => loadAppointments(showLoading: false);
}
