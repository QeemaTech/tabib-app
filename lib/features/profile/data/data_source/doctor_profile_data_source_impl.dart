import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/data/data_source/doctor_profile_data_source.dart';
import 'package:tabib_app/features/profile/data/models/response/doctor_profile_response.dart';

@LazySingleton(as: DoctorProfileDataSource)
class DoctorProfileDataSourceImpl implements DoctorProfileDataSource {
  final ApiClient apiClient;

  DoctorProfileDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorProfileResponse>> getDoctorProfile() {
    return executeApi(() => apiClient.getDoctorProfile());
  }
}
