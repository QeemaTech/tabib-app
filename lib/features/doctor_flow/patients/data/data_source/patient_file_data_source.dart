import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/models/response/patient_file_response.dart';

abstract interface class PatientFileDataSource {
  Future<Result<PatientFileResponse>> getPatientFile(String appointmentId);
}
