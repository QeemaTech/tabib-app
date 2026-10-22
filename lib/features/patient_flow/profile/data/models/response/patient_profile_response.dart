import 'package:json_annotation/json_annotation.dart';

part 'patient_profile_response.g.dart';

@JsonSerializable()
class PatientProfileResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientProfileDataResponse? data;

  PatientProfileResponse({
    this.success,
    this.data,
  });

  factory PatientProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientProfileResponseToJson(this);
}

@JsonSerializable()
class PatientProfileDataResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'fullNameSo')
  final String? fullNameSo;
  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'heightCm')
  final num? heightCm;
  @JsonKey(name: 'weightKg')
  final num? weightKg;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'bloodType')
  final String? bloodType;
  @JsonKey(name: 'allergies')
  final String? allergies;
  @JsonKey(name: 'chronicConditions')
  final String? chronicConditions;
  @JsonKey(name: 'currentMedications')
  final String? currentMedications;
  @JsonKey(name: 'hasMedicationAllergy')
  final bool? hasMedicationAllergy;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'isVerified')
  final bool? isVerified;

  PatientProfileDataResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.fullNameSo,
    this.dateOfBirth,
    this.gender,
    this.heightCm,
    this.weightKg,
    this.avatarUrl,
    this.bloodType,
    this.allergies,
    this.chronicConditions,
    this.currentMedications,
    this.hasMedicationAllergy,
    this.phone,
    this.email,
    this.isVerified,
  });

  factory PatientProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientProfileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientProfileDataResponseToJson(this);
}
