import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/models/response/doctor_patients_response.dart';

abstract interface class DoctorPatientsDataSource {
  Future<Result<DoctorPatientsResponse>> getPatients({
    String? search,
    required String filter,
  });
}
