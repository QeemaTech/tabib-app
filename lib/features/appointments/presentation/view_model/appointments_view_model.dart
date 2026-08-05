import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:tabib_app/features/appointments/domain/repo/appointments_repo.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointments_state.dart';

@injectable
class AppointmentsViewModel extends Cubit<AppointmentsState> {
  final AppointmentsRepo appointmentsRepo;

  AppointmentsViewModel({required this.appointmentsRepo})
      : super(const AppointmentsState());

  Future<void> loadAppointments({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(appointmentsState: BaseState.loading()));
    }
    final result = await appointmentsRepo.getAppointments();
    switch (result) {
      case Success<List<PatientAppointmentEntity>>():
        emit(
          state.copyWith(
            appointmentsState: BaseState.loaded(result.data),
          ),
        );
      case Failure<List<PatientAppointmentEntity>>():
        emit(
          state.copyWith(
            appointmentsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry() => loadAppointments();

  Future<void> refreshAppointments() => loadAppointments(showLoading: false);

  Future<void> cancelAppointment({
    required String id,
    required String cancelReason,
  }) async {
    final trimmedReason = cancelReason.trim();
    if (trimmedReason.isEmpty) {
      emit(
        state.copyWith(
          cancelAppointmentState: BaseState.error(
            'appointments.cancelReasonRequired'.tr(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(cancelAppointmentState: BaseState.loading()));
    final result = await appointmentsRepo.cancelAppointment(
      id: id,
      cancelReason: trimmedReason,
    );
    switch (result) {
      case Success<PatientAppointmentEntity>():
        final cancelled = result.data;
        final currentList = state.appointmentsState.data ?? const [];
        final updatedList = currentList.map((item) {
          if (item.id != cancelled.id) return item;
          return item.copyWith(
            status: cancelled.status,
            cancelReason: cancelled.cancelReason,
            notes: cancelled.notes,
          );
        }).toList();
        emit(
          state.copyWith(
            cancelAppointmentState: BaseState.loaded(cancelled),
            appointmentsState: BaseState.loaded(updatedList),
          ),
        );
      case Failure<PatientAppointmentEntity>():
        emit(
          state.copyWith(
            cancelAppointmentState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
