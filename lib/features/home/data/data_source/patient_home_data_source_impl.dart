import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/data/data_source/patient_home_data_source.dart';
import 'package:tabib_app/features/home/data/models/response/patient_home_response.dart';

@LazySingleton(as: PatientHomeDataSource)
class PatientHomeDataSourceImpl implements PatientHomeDataSource {
  final ApiClient apiClient;

  PatientHomeDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientHomeResponse>> getPatientHome() {
    return executeApi(() => apiClient.getPatientHome());
  }
}
