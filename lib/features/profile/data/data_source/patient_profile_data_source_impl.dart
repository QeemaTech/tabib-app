import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/data/data_source/patient_profile_data_source.dart';
import 'package:tabib_app/features/profile/data/models/request/update_patient_profile_request.dart';
import 'package:tabib_app/features/profile/data/models/response/patient_profile_response.dart';

@LazySingleton(as: PatientProfileDataSource)
class PatientProfileDataSourceImpl implements PatientProfileDataSource {
  final ApiClient apiClient;

  PatientProfileDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientProfileResponse>> getPatientProfile() {
    return executeApi(() => apiClient.getPatientProfile());
  }

  @override
  Future<Result<PatientProfileResponse>> updatePatientProfile(
    UpdatePatientProfileRequest request,
  ) {
    return executeApi(() => apiClient.updatePatientProfile(request));
  }
}
