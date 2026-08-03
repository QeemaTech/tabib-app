import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/patient_home_entity.dart';

abstract interface class PatientHomeRepo {
  Future<Result<PatientHomeEntity>> getPatientHome();
}
