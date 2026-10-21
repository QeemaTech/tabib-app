import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/records/data/models/response/patient_record_common_response.dart';

part 'patient_reports_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientReportsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<PatientReportListItemResponse>? data;
  @JsonKey(name: 'meta')
  final PatientRecordMetaResponse? meta;

  PatientReportsResponse({this.success, this.data, this.meta});

  factory PatientReportsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientReportsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientReportsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientReportListItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'referenceNumber')
  final String? referenceNumber;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'occurredAt')
  final String? occurredAt;
  @JsonKey(name: 'doctor')
  final PatientRecordDoctorResponse? doctor;
  @JsonKey(name: 'summaryAr')
  final String? summaryAr;
  @JsonKey(name: 'summaryEn')
  final String? summaryEn;
  @JsonKey(name: 'diagnosisAr')
  final String? diagnosisAr;
  @JsonKey(name: 'visitTypeAr')
  final String? visitTypeAr;
  @JsonKey(name: 'bloodPressure')
  final String? bloodPressure;
  @JsonKey(name: 'temperature')
  final String? temperature;
  @JsonKey(name: 'followUpAr')
  final String? followUpAr;
  @JsonKey(name: 'prescriptionsCount')
  final int? prescriptionsCount;
  @JsonKey(name: 'filesCount')
  final int? filesCount;
  @JsonKey(name: 'requestedTestsCount')
  final int? requestedTestsCount;

  PatientReportListItemResponse({
    this.id,
    this.referenceNumber,
    this.appointmentId,
    this.occurredAt,
    this.doctor,
    this.summaryAr,
    this.summaryEn,
    this.diagnosisAr,
    this.visitTypeAr,
    this.bloodPressure,
    this.temperature,
    this.followUpAr,
    this.prescriptionsCount,
    this.filesCount,
    this.requestedTestsCount,
  });

  factory PatientReportListItemResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientReportListItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientReportListItemResponseToJson(this);
}
