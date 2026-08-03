import 'package:tabib_app/features/auth/data/models/response/patient_health_profile_response.dart';
import 'package:tabib_app/features/auth/domain/entities/health_profile_file_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_health_profile_result_entity.dart';

extension PatientHealthProfileResponseMapper on PatientHealthProfileResponse {
  PatientHealthProfileResultEntity toEntity() {
    final data = this.data;
    return PatientHealthProfileResultEntity(
      dateOfBirth: data?.dateOfBirth ?? '',
      gender: data?.gender ?? '',
      heightCm: data?.heightCm ?? 0,
      weightKg: data?.weightKg ?? 0,
      files: data?.files?.map((file) => file.toEntity()).toList() ?? const [],
    );
  }
}

extension HealthProfileFileResponseMapper on HealthProfileFileResponse {
  HealthProfileFileEntity toEntity() {
    return HealthProfileFileEntity(
      id: id ?? '',
      fileName: fileName ?? '',
      fileUrl: fileUrl ?? '',
      fileType: fileType ?? '',
      fileSize: fileSize ?? 0,
      createdAt: createdAt ?? '',
    );
  }
}
