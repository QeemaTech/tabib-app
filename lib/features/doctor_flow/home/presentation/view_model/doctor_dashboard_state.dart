import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/home/domain/entities/doctor_dashboard_entity.dart';

enum DashboardPendingActionType { accept, reject }

class DoctorDashboardState extends Equatable {
  final BaseState<DoctorDashboardEntity> dashboardState;
  final BaseState<DashboardPendingActionType> actionState;
  final String? actionAppointmentId;

  const DoctorDashboardState({
    this.dashboardState = const BaseState(requestState: RequestState.init),
    this.actionState = const BaseState(requestState: RequestState.init),
    this.actionAppointmentId,
  });

  DoctorDashboardState copyWith({
    BaseState<DoctorDashboardEntity>? dashboardState,
    BaseState<DashboardPendingActionType>? actionState,
    String? actionAppointmentId,
    bool clearActionAppointmentId = false,
  }) {
    return DoctorDashboardState(
      dashboardState: dashboardState ?? this.dashboardState,
      actionState: actionState ?? this.actionState,
      actionAppointmentId: clearActionAppointmentId
          ? null
          : (actionAppointmentId ?? this.actionAppointmentId),
    );
  }

  @override
  List<Object?> get props =>
      [dashboardState, actionState, actionAppointmentId];
}
