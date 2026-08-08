import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patients/domain/entities/patient_file_entity.dart';

abstract interface class PatientFileRepo {
  Future<Result<PatientFileEntity>> getPatientFile(String appointmentId);
}
