import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_record_common_response.dart';

part 'patient_record_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientRecordDetailResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientRecordDetailDataResponse? data;

  PatientRecordDetailResponse({this.success, this.data});

  factory PatientRecordDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRecordDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientRecordDetailDataResponse {
  @JsonKey(name: 'mode')
  final String? mode;
  @JsonKey(name: 'screenTitleAr')
  final String? screenTitleAr;
  @JsonKey(name: 'screenTitleEn')
  final String? screenTitleEn;
  @JsonKey(name: 'detail')
  final PatientRecordDetailBodyResponse? detail;
  @JsonKey(name: 'actions')
  final PatientRecordActionsResponse? actions;

  PatientRecordDetailDataResponse({
    this.mode,
    this.screenTitleAr,
    this.screenTitleEn,
    this.detail,
    this.actions,
  });

  factory PatientRecordDetailDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordDetailDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientRecordDetailDataResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientRecordDetailBodyResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'typeLabelAr')
  final String? typeLabelAr;
  @JsonKey(name: 'typeLabelEn')
  final String? typeLabelEn;
  @JsonKey(name: 'referenceNumber')
  final String? referenceNumber;
  @JsonKey(name: 'referenceLabelAr')
  final String? referenceLabelAr;
  @JsonKey(name: 'referenceLabelEn')
  final String? referenceLabelEn;
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
  @JsonKey(name: 'diagnoses')
  final List<PatientRecordDiagnosisResponse>? diagnoses;
  @JsonKey(name: 'visitTypeAr')
  final String? visitTypeAr;
  @JsonKey(name: 'bloodPressure')
  final String? bloodPressure;
  @JsonKey(name: 'temperature')
  final String? temperature;
  @JsonKey(name: 'followUpAr')
  final String? followUpAr;
  @JsonKey(name: 'medicalNotesAr')
  final String? medicalNotesAr;
  @JsonKey(name: 'requestedTests')
  final List<PatientRequestedTestResponse>? requestedTests;
  @JsonKey(name: 'prescriptionsCount')
  final int? prescriptionsCount;
  @JsonKey(name: 'medications')
  final List<PatientRecordMedicationResponse>? medications;
  @JsonKey(name: 'medicalRecordId')
  final String? medicalRecordId;
  @JsonKey(name: 'prescriptionId')
  final String? prescriptionId;
  @JsonKey(name: 'viewUrl')
  final String? viewUrl;
  @JsonKey(name: 'downloadUrl')
  final String? downloadUrl;

  PatientRecordDetailBodyResponse({
    this.id,
    this.type,
    this.typeLabelAr,
    this.typeLabelEn,
    this.referenceNumber,
    this.referenceLabelAr,
    this.referenceLabelEn,
    this.occurredAt,
    this.doctor,
    this.summaryAr,
    this.summaryEn,
    this.diagnosisAr,
    this.diagnoses,
    this.visitTypeAr,
    this.bloodPressure,
    this.temperature,
    this.followUpAr,
    this.medicalNotesAr,
    this.requestedTests,
    this.prescriptionsCount,
    this.medications,
    this.medicalRecordId,
    this.prescriptionId,
    this.viewUrl,
    this.downloadUrl,
  });

  factory PatientRecordDetailBodyResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordDetailBodyResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientRecordDetailBodyResponseToJson(this);
}
