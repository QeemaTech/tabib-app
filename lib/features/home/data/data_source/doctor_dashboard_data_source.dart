import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_dashboard_response.dart';

abstract interface class DoctorDashboardDataSource {
  Future<Result<DoctorDashboardResponse>> getDoctorDashboard();
}
