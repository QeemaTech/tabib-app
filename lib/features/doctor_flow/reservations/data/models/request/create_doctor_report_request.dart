import 'package:json_annotation/json_annotation.dart';

part 'create_doctor_report_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateDoctorReportRequest {
  @JsonKey(name: 'visitTypeAr')
  final String? visitTypeAr;
  @JsonKey(name: 'bloodPressure')
  final String? bloodPressure;
  @JsonKey(name: 'temperature')
  final String? temperature;
  @JsonKey(name: 'diagnosis')
  final String? diagnosis;
  @JsonKey(name: 'medications')
  final List<CreateDoctorReportMedicationRequest>? medications;
  @JsonKey(name: 'requiredTests')
  final List<String>? requiredTests;
  @JsonKey(name: 'followUpAr')
  final String? followUpAr;
  @JsonKey(name: 'medicalNotesAr')
  final String? medicalNotesAr;

  CreateDoctorReportRequest({
    this.visitTypeAr,
    this.bloodPressure,
    this.temperature,
    this.diagnosis,
    this.medications,
    this.requiredTests,
    this.followUpAr,
    this.medicalNotesAr,
  });

  factory CreateDoctorReportRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDoctorReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDoctorReportRequestToJson(this);
}

@JsonSerializable()
class CreateDoctorReportMedicationRequest {
  @JsonKey(name: 'drugNameAr')
  final String? drugNameAr;
  @JsonKey(name: 'dosage')
  final String? dosage;
  @JsonKey(name: 'frequency')
  final String? frequency;
  @JsonKey(name: 'duration')
  final String? duration;

  CreateDoctorReportMedicationRequest({
    this.drugNameAr,
    this.dosage,
    this.frequency,
    this.duration,
  });

  factory CreateDoctorReportMedicationRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CreateDoctorReportMedicationRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateDoctorReportMedicationRequestToJson(this);
}
