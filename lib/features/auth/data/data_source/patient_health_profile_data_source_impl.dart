import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/data_source/patient_health_profile_data_source.dart';
import 'package:tabib_app/features/auth/data/models/response/patient_health_profile_response.dart';
import 'package:tabib_app/features/auth/data/models/response/patient_medical_info_response.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_health_profile_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_medical_info_entity.dart';

@LazySingleton(as: PatientHealthProfileDataSource)
class PatientHealthProfileDataSourceImpl
    implements PatientHealthProfileDataSource {
  final ApiClient apiClient;

  PatientHealthProfileDataSourceImpl(this.apiClient);

  Future<List<MultipartFile>> _toMultipartFiles(List<String> paths) async {
    return Future.wait(
      paths.map((path) => MultipartFile.fromFile(path)),
    );
  }

  @override
  Future<Result<PatientHealthProfileResponse>> updateHealthProfile(
    PatientHealthProfileEntity entity,
  ) {
    return executeApi(() async {
      final files = await _toMultipartFiles(entity.files);
      return apiClient.updatePatientHealthProfile(
        dateOfBirth: entity.dateOfBirth,
        gender: entity.gender,
        heightCm: entity.heightCm,
        weightKg: entity.weightKg,
        files: files,
      );
    });
  }

  @override
  Future<Result<PatientMedicalInfoResponse>> updateMedicalInfo(
    PatientMedicalInfoEntity entity,
  ) {
    return executeApi(() async {
      final files = await _toMultipartFiles(entity.files);
      return apiClient.updatePatientMedicalInfo(
        chronicConditions: entity.chronicConditions,
        currentMedications: entity.currentMedications,
        hasMedicationAllergy: entity.hasMedicationAllergy,
        allergyDetails: entity.allergyDetails,
        files: files,
      );
    });
  }
}
