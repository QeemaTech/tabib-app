import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/patients/domain/entities/doctor_patient_entity.dart';

abstract interface class DoctorPatientsRepo {
  Future<Result<List<DoctorPatientEntity>>> getPatients({
    String? search,
    required String filter,
  });
}
