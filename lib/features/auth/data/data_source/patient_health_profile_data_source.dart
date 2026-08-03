import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/models/response/patient_health_profile_response.dart';
import 'package:tabib_app/features/auth/data/models/response/patient_medical_info_response.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_health_profile_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_medical_info_entity.dart';

abstract interface class PatientHealthProfileDataSource {
  Future<Result<PatientHealthProfileResponse>> updateHealthProfile(
    PatientHealthProfileEntity entity,
  );

  Future<Result<PatientMedicalInfoResponse>> updateMedicalInfo(
    PatientMedicalInfoEntity entity,
  );
}
