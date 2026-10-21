import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/records/data/models/response/patient_record_common_response.dart';

part 'patient_prescriptions_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientPrescriptionsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<PatientPrescriptionListItemResponse>? data;
  @JsonKey(name: 'meta')
  final PatientRecordMetaResponse? meta;

  PatientPrescriptionsResponse({this.success, this.data, this.meta});

  factory PatientPrescriptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientPrescriptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientPrescriptionsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientPrescriptionListItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'referenceNumber')
  final String? referenceNumber;
  @JsonKey(name: 'issuedAt')
  final String? issuedAt;
  @JsonKey(name: 'doctor')
  final PatientRecordDoctorResponse? doctor;
  @JsonKey(name: 'notesAr')
  final String? notesAr;
  @JsonKey(name: 'summaryAr')
  final String? summaryAr;
  @JsonKey(name: 'itemsCount')
  final int? itemsCount;
  @JsonKey(name: 'items')
  final List<PatientRecordMedicationResponse>? items;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'medicalRecordId')
  final String? medicalRecordId;

  PatientPrescriptionListItemResponse({
    this.id,
    this.referenceNumber,
    this.issuedAt,
    this.doctor,
    this.notesAr,
    this.summaryAr,
    this.itemsCount,
    this.items,
    this.appointmentId,
    this.medicalRecordId,
  });

  factory PatientPrescriptionListItemResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$PatientPrescriptionListItemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientPrescriptionListItemResponseToJson(this);
}
