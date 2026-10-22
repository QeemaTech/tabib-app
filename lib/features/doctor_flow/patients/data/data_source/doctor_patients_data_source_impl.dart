import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/data_source/doctor_patients_data_source.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/models/response/doctor_patients_response.dart';

@LazySingleton(as: DoctorPatientsDataSource)
class DoctorPatientsDataSourceImpl implements DoctorPatientsDataSource {
  final ApiClient apiClient;

  DoctorPatientsDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorPatientsResponse>> getPatients({
    String? search,
    required String filter,
  }) {
    return executeApi(
      () => apiClient.getDoctorPatients(
        search: search,
        filter: filter,
      ),
    );
  }
}
