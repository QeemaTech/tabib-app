import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_health_profile_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_health_profile_result_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_medical_info_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_medical_info_result_entity.dart';

abstract interface class PatientHealthProfileRepo {
  Future<Result<PatientHealthProfileResultEntity>> updateHealthProfile(
    PatientHealthProfileEntity entity,
  );

  Future<Result<PatientMedicalInfoResultEntity>> updateMedicalInfo(
    PatientMedicalInfoEntity entity,
  );
}
