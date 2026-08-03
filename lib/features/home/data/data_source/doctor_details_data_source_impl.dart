import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/data/data_source/doctor_details_data_source.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_details_response.dart';

@LazySingleton(as: DoctorDetailsDataSource)
class DoctorDetailsDataSourceImpl implements DoctorDetailsDataSource {
  final ApiClient apiClient;

  DoctorDetailsDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorDetailsResponse>> getDoctorDetails(String id) {
    return executeApi(() => apiClient.getPatientDoctorDetails(id));
  }
}
