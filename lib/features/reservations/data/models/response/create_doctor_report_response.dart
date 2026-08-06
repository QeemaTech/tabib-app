import 'package:json_annotation/json_annotation.dart';

part 'create_doctor_report_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateDoctorReportResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final CreateDoctorReportDataResponse? data;

  CreateDoctorReportResponse({
    this.success,
    this.data,
  });

  factory CreateDoctorReportResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateDoctorReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDoctorReportResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateDoctorReportDataResponse {
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'medicalRecordId')
  final String? medicalRecordId;
  @JsonKey(name: 'visitTypeAr')
  final String? visitTypeAr;
  @JsonKey(name: 'bloodPressure')
  final String? bloodPressure;
  @JsonKey(name: 'temperature')
  final String? temperature;
  @JsonKey(name: 'diagnosis')
  final String? diagnosis;
  @JsonKey(name: 'medications')
  final List<CreateDoctorReportMedicationResponse>? medications;
  @JsonKey(name: 'requiredTests')
  final List<CreateDoctorReportTestResponse>? requiredTests;
  @JsonKey(name: 'followUpAr')
  final String? followUpAr;
  @JsonKey(name: 'medicalNotesAr')
  final String? medicalNotesAr;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  CreateDoctorReportDataResponse({
    this.appointmentId,
    this.medicalRecordId,
    this.visitTypeAr,
    this.bloodPressure,
    this.temperature,
    this.diagnosis,
    this.medications,
    this.requiredTests,
    this.followUpAr,
    this.medicalNotesAr,
    this.createdAt,
  });

  factory CreateDoctorReportDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateDoctorReportDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateDoctorReportDataResponseToJson(this);
}

@JsonSerializable()
class CreateDoctorReportMedicationResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'drugNameAr')
  final String? drugNameAr;
  @JsonKey(name: 'drugNameEn')
  final String? drugNameEn;
  @JsonKey(name: 'dosage')
  final String? dosage;
  @JsonKey(name: 'frequency')
  final String? frequency;
  @JsonKey(name: 'duration')
  final String? duration;
  @JsonKey(name: 'instructionsAr')
  final String? instructionsAr;

  CreateDoctorReportMedicationResponse({
    this.id,
    this.drugNameAr,
    this.drugNameEn,
    this.dosage,
    this.frequency,
    this.duration,
    this.instructionsAr,
  });

  factory CreateDoctorReportMedicationResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CreateDoctorReportMedicationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateDoctorReportMedicationResponseToJson(this);
}

@JsonSerializable()
class CreateDoctorReportTestResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'titleAr')
  final String? titleAr;

  CreateDoctorReportTestResponse({
    this.id,
    this.titleAr,
  });

  factory CreateDoctorReportTestResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateDoctorReportTestResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateDoctorReportTestResponseToJson(this);
}
