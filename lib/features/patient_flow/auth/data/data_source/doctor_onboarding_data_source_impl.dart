import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/data/data_source/doctor_onboarding_data_source.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/specialties_response.dart';

@LazySingleton(as: PatientCatalogDataSource)
class PatientCatalogDataSourceImpl implements PatientCatalogDataSource {
  final ApiClient apiClient;

  PatientCatalogDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientSpecialtiesResponse>> getSpecialties({String? parentId}) {
    return executeApi(
      () => apiClient.getPatientSpecialties(parentId: parentId),
    );
  }
}
