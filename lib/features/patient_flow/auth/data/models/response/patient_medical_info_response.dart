import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/patient_health_profile_response.dart';

part 'patient_medical_info_response.g.dart';

@JsonSerializable()
class PatientMedicalInfoResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientMedicalInfoData? data;

  PatientMedicalInfoResponse({
    this.success,
    this.data,
  });

  factory PatientMedicalInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientMedicalInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientMedicalInfoResponseToJson(this);
}

@JsonSerializable()
class PatientMedicalInfoData {
  @JsonKey(name: 'chronicConditions')
  final String? chronicConditions;
  @JsonKey(name: 'currentMedications')
  final String? currentMedications;
  @JsonKey(name: 'hasMedicationAllergy')
  final bool? hasMedicationAllergy;
  @JsonKey(name: 'allergyDetails')
  final String? allergyDetails;
  @JsonKey(name: 'files')
  final List<HealthProfileFileResponse>? files;

  PatientMedicalInfoData({
    this.chronicConditions,
    this.currentMedications,
    this.hasMedicationAllergy,
    this.allergyDetails,
    this.files,
  });

  factory PatientMedicalInfoData.fromJson(Map<String, dynamic> json) =>
      _$PatientMedicalInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientMedicalInfoDataToJson(this);
}
