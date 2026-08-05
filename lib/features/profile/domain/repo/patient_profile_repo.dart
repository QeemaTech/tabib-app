import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';

abstract interface class PatientProfileRepo {
  Future<Result<PatientProfileEntity>> getPatientProfile();
}
