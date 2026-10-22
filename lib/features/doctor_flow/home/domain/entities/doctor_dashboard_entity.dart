import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/doctor_flow/home/domain/entities/doctor_dashboard_appointment_entity.dart';
import 'package:tabib_app/features/doctor_flow/home/domain/entities/doctor_dashboard_stats_entity.dart';

class DoctorDashboardEntity extends Equatable {
  final List<DoctorDashboardAppointmentEntity> todayAppointments;
  final List<DoctorDashboardAppointmentEntity> pendingRequests;
  final DoctorDashboardStatsEntity stats;

  const DoctorDashboardEntity({
    required this.todayAppointments,
    required this.pendingRequests,
    required this.stats,
  });

  @override
  List<Object?> get props => [todayAppointments, pendingRequests, stats];
}
