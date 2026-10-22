import 'package:tabib_app/features/patient_flow/auth/data/mapper/patient_health_profile_mapper.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/patient_medical_info_response.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_medical_info_result_entity.dart';

extension PatientMedicalInfoResponseMapper on PatientMedicalInfoResponse {
  PatientMedicalInfoResultEntity toEntity() {
    final data = this.data;
    return PatientMedicalInfoResultEntity(
      chronicConditions: data?.chronicConditions ?? '',
      currentMedications: data?.currentMedications ?? '',
      hasMedicationAllergy: data?.hasMedicationAllergy ?? false,
      allergyDetails: data?.allergyDetails ?? '',
      files: data?.files?.map((file) => file.toEntity()).toList() ?? const [],
    );
  }
}
