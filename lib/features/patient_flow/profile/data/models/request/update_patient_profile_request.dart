import 'package:json_annotation/json_annotation.dart';

part 'update_patient_profile_request.g.dart';

@JsonSerializable()
class UpdatePatientProfileRequest {
  @JsonKey(name: 'fullNameAr')
  final String fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String fullNameEn;
  @JsonKey(name: 'fullNameSo')
  final String fullNameSo;
  @JsonKey(name: 'dateOfBirth')
  final String dateOfBirth;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'bloodType')
  final String bloodType;
  @JsonKey(name: 'allergies')
  final String allergies;
  @JsonKey(name: 'chronicConditions')
  final String chronicConditions;

  const UpdatePatientProfileRequest({
    required this.fullNameAr,
    required this.fullNameEn,
    required this.fullNameSo,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
  });

  factory UpdatePatientProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePatientProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePatientProfileRequestToJson(this);
}
