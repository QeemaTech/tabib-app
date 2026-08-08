import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patients/data/data_source/patient_file_data_source.dart';
import 'package:tabib_app/features/patients/data/models/response/patient_file_response.dart';

@LazySingleton(as: PatientFileDataSource)
class PatientFileDataSourceImpl implements PatientFileDataSource {
  final ApiClient apiClient;

  PatientFileDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientFileResponse>> getPatientFile(String appointmentId) {
    return executeApi(
      () => apiClient.getDoctorAppointmentPatientFile(appointmentId),
    );
  }
}
