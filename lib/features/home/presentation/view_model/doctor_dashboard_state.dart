import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_entity.dart';

class DoctorDashboardState extends Equatable {
  final BaseState<DoctorDashboardEntity> dashboardState;

  const DoctorDashboardState({
    this.dashboardState = const BaseState(requestState: RequestState.init),
  });

  DoctorDashboardState copyWith({
    BaseState<DoctorDashboardEntity>? dashboardState,
  }) {
    return DoctorDashboardState(
      dashboardState: dashboardState ?? this.dashboardState,
    );
  }

  @override
  List<Object?> get props => [dashboardState];
}
