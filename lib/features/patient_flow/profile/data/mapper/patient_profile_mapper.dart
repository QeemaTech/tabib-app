import 'package:tabib_app/features/patient_flow/profile/data/models/response/patient_profile_response.dart';
import 'package:tabib_app/features/patient_flow/profile/domain/entities/patient_profile_entity.dart';

extension PatientProfileDataResponseMapper on PatientProfileDataResponse {
  PatientProfileEntity toEntity() {
    return PatientProfileEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      fullNameSo: fullNameSo ?? '',
      dateOfBirth: dateOfBirth ?? '',
      gender: gender ?? '',
      heightCm: heightCm?.toInt() ?? 0,
      weightKg: weightKg?.toInt() ?? 0,
      avatarUrl: avatarUrl ?? '',
      bloodType: bloodType ?? '',
      allergies: allergies ?? '',
      chronicConditions: chronicConditions ?? '',
      currentMedications: currentMedications ?? '',
      hasMedicationAllergy: hasMedicationAllergy ?? false,
      phone: phone ?? '',
      email: email ?? '',
      isVerified: isVerified ?? false,
    );
  }
}
