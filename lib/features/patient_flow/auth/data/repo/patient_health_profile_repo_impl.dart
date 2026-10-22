import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/data/data_source/patient_health_profile_data_source.dart';
import 'package:tabib_app/features/patient_flow/auth/data/mapper/patient_health_profile_mapper.dart';
import 'package:tabib_app/features/patient_flow/auth/data/mapper/patient_medical_info_mapper.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/patient_health_profile_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/patient_medical_info_response.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_health_profile_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_health_profile_result_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_medical_info_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_medical_info_result_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/repo/patient_health_profile_repo.dart';

@LazySingleton(as: PatientHealthProfileRepo)
class PatientHealthProfileRepoImpl implements PatientHealthProfileRepo {
  final PatientHealthProfileDataSource dataSource;

  PatientHealthProfileRepoImpl(this.dataSource);

  @override
  Future<Result<PatientHealthProfileResultEntity>> updateHealthProfile(
    PatientHealthProfileEntity entity,
  ) async {
    final response = await dataSource.updateHealthProfile(entity);
    switch (response) {
      case Success<PatientHealthProfileResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientHealthProfileResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientMedicalInfoResultEntity>> updateMedicalInfo(
    PatientMedicalInfoEntity entity,
  ) async {
    final response = await dataSource.updateMedicalInfo(entity);
    switch (response) {
      case Success<PatientMedicalInfoResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientMedicalInfoResponse>():
        return Failure(response.errorMessage);
    }
  }
}
