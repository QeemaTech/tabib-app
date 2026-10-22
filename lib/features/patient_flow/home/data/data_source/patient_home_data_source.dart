import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/patient_home_response.dart';

abstract interface class PatientHomeDataSource {
  Future<Result<PatientHomeResponse>> getPatientHome();
}
