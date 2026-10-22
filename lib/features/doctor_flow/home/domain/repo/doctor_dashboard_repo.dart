import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/home/domain/entities/doctor_dashboard_entity.dart';

abstract interface class DoctorDashboardRepo {
  Future<Result<DoctorDashboardEntity>> getDoctorDashboard();
}
