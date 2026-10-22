import 'package:json_annotation/json_annotation.dart';

part 'patient_health_profile_response.g.dart';

@JsonSerializable()
class PatientHealthProfileResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientHealthProfileData? data;

  PatientHealthProfileResponse({
    this.success,
    this.data,
  });

  factory PatientHealthProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientHealthProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientHealthProfileResponseToJson(this);
}

@JsonSerializable()
class PatientHealthProfileData {
  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'heightCm')
  final int? heightCm;
  @JsonKey(name: 'weightKg')
  final int? weightKg;
  @JsonKey(name: 'files')
  final List<HealthProfileFileResponse>? files;

  PatientHealthProfileData({
    this.dateOfBirth,
    this.gender,
    this.heightCm,
    this.weightKg,
    this.files,
  });

  factory PatientHealthProfileData.fromJson(Map<String, dynamic> json) =>
      _$PatientHealthProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientHealthProfileDataToJson(this);
}

@JsonSerializable()
class HealthProfileFileResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fileName')
  final String? fileName;
  @JsonKey(name: 'fileUrl')
  final String? fileUrl;
  @JsonKey(name: 'fileType')
  final String? fileType;
  @JsonKey(name: 'fileSize')
  final int? fileSize;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  HealthProfileFileResponse({
    this.id,
    this.fileName,
    this.fileUrl,
    this.fileType,
    this.fileSize,
    this.createdAt,
  });

  factory HealthProfileFileResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthProfileFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HealthProfileFileResponseToJson(this);
}
