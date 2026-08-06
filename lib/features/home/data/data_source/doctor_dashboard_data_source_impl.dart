import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/data/data_source/doctor_dashboard_data_source.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_dashboard_response.dart';

@LazySingleton(as: DoctorDashboardDataSource)
class DoctorDashboardDataSourceImpl implements DoctorDashboardDataSource {
  final ApiClient apiClient;

  DoctorDashboardDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorDashboardResponse>> getDoctorDashboard() {
    return executeApi(() => apiClient.getDoctorDashboard());
  }
}
