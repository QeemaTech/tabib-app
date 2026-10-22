import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/profile/domain/entities/patient_profile_entity.dart';

abstract interface class PatientProfileRepo {
  Future<Result<PatientProfileEntity>> getPatientProfile();

  Future<Result<PatientProfileEntity>> updatePatientProfile({
    required String fullNameAr,
    required String fullNameEn,
    required String fullNameSo,
    required String dateOfBirth,
    required String gender,
    required String bloodType,
    required String allergies,
    required String chronicConditions,
  });
}
