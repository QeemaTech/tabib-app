import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/repo/doctor_appointments_repo.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/doctor_appointments_state.dart';

@injectable
class DoctorAppointmentsViewModel extends Cubit<DoctorAppointmentsState> {
  final DoctorAppointmentsRepo doctorAppointmentsRepo;

  DoctorAppointmentsViewModel({required this.doctorAppointmentsRepo})
      : super(DoctorAppointmentsState());

  void onFilterChanged(DoctorAppointmentsFilter filter) {
    if (state.filter == filter) return;
    emit(state.copyWith(filter: filter));
    loadAppointments();
  }

  void onDaySelected(DateTime day) {
    final dateOnly = DateTime(day.year, day.month, day.day);
    if (dateOnly == state.selectedDate) return;
    emit(state.copyWith(selectedDate: dateOnly));
    loadAppointments();
  }

  Future<void> loadAppointments({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(appointmentsState: BaseState.loading()));
    }

    final date = state.filter == DoctorAppointmentsFilter.all
        ? DateFormat('yyyy-MM-dd').format(state.selectedDate)
        : null;

    final result = await doctorAppointmentsRepo.getAppointments(
      status: state.apiStatus,
      date: date,
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

  Future<void> acceptAppointment(String id) async {
    emit(
      state.copyWith(
        actionState: BaseState.loading(),
        actionAppointmentId: id,
      ),
    );

    final result = await doctorAppointmentsRepo.acceptAppointment(id);
    switch (result) {
      case Success<DoctorAppointmentEntity>():
        emit(
          state.copyWith(
            appointmentsState: BaseState.loaded(_withoutAppointment(id)),
            actionState: BaseState.loaded(DoctorAppointmentActionType.accept),
            clearActionAppointmentId: true,
          ),
        );
      case Failure<DoctorAppointmentEntity>():
        emit(
          state.copyWith(
            actionState: BaseState.error(result.errorMessage),
            clearActionAppointmentId: true,
          ),
        );
    }
  }

  Future<void> rejectAppointment({
    required String id,
    required String reason,
  }) async {
    emit(
      state.copyWith(
        actionState: BaseState.loading(),
        actionAppointmentId: id,
      ),
    );

    final result = await doctorAppointmentsRepo.rejectAppointment(
      id: id,
      reason: reason,
    );
    switch (result) {
      case Success<DoctorAppointmentEntity>():
        emit(
          state.copyWith(
            appointmentsState: BaseState.loaded(_withoutAppointment(id)),
            actionState: BaseState.loaded(DoctorAppointmentActionType.reject),
            clearActionAppointmentId: true,
          ),
        );
      case Failure<DoctorAppointmentEntity>():
        emit(
          state.copyWith(
            actionState: BaseState.error(result.errorMessage),
            clearActionAppointmentId: true,
          ),
        );
    }
  }

  void resetActionState() {
    emit(
      state.copyWith(
        actionState: const BaseState(requestState: RequestState.init),
        clearActionAppointmentId: true,
      ),
    );
  }

  List<DoctorAppointmentEntity> _withoutAppointment(String id) {
    final current = state.appointmentsState.data ?? const [];
    return current.where((appointment) => appointment.id != id).toList();
  }

  Future<void> retry() => loadAppointments();

  Future<void> refresh() => loadAppointments(showLoading: false);
}
