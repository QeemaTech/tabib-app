import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_stats_entity.dart';
import 'package:tabib_app/features/home/domain/repo/doctor_dashboard_repo.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_state.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/domain/repo/doctor_appointments_repo.dart';

@injectable
class DoctorDashboardViewModel extends Cubit<DoctorDashboardState> {
  final DoctorDashboardRepo doctorDashboardRepo;
  final DoctorAppointmentsRepo doctorAppointmentsRepo;

  DoctorDashboardViewModel({
    required this.doctorDashboardRepo,
    required this.doctorAppointmentsRepo,
  }) : super(const DoctorDashboardState());

  Future<void> loadDashboard() async {
    emit(state.copyWith(dashboardState: BaseState.loading()));
    final result = await doctorDashboardRepo.getDoctorDashboard();
    switch (result) {
      case Success<DoctorDashboardEntity>():
        emit(
          state.copyWith(
            dashboardState: BaseState.loaded(result.data),
          ),
        );
      case Failure<DoctorDashboardEntity>():
        emit(
          state.copyWith(
            dashboardState: BaseState.error(result.errorMessage),
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
            dashboardState: BaseState.loaded(_withoutPending(id)),
            actionState: BaseState.loaded(DashboardPendingActionType.accept),
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
            dashboardState: BaseState.loaded(_withoutPending(id)),
            actionState: BaseState.loaded(DashboardPendingActionType.reject),
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

  DoctorDashboardEntity _withoutPending(String id) {
    final current = state.dashboardState.data;
    if (current == null) {
      return const DoctorDashboardEntity(
        todayAppointments: [],
        pendingRequests: [],
        stats: DoctorDashboardStatsEntity(
          todayCount: 0,
          weekCount: 0,
          completedCount: 0,
          totalCompletedCount: 0,
          pendingCount: 0,
          rating: 0,
          ratingCount: 0,
          earnings: 0,
        ),
      );
    }

    final pending = current.pendingRequests
        .where((request) => request.id != id)
        .toList(growable: false);
    final stats = current.stats;
    return DoctorDashboardEntity(
      todayAppointments: current.todayAppointments,
      pendingRequests: pending,
      stats: DoctorDashboardStatsEntity(
        todayCount: stats.todayCount,
        weekCount: stats.weekCount,
        completedCount: stats.completedCount,
        totalCompletedCount: stats.totalCompletedCount,
        pendingCount: pending.length,
        rating: stats.rating,
        ratingCount: stats.ratingCount,
        earnings: stats.earnings,
      ),
    );
  }
}
