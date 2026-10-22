import 'package:json_annotation/json_annotation.dart';

part 'patient_record_common_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientRecordMetaResponse {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'totalPages')
  final int? totalPages;

  PatientRecordMetaResponse({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory PatientRecordMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRecordMetaResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientRecordDoctorResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'specialtyAr')
  final String? specialtyAr;
  @JsonKey(name: 'specialtyEn')
  final String? specialtyEn;

  PatientRecordDoctorResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.specialtyAr,
    this.specialtyEn,
  });

  factory PatientRecordDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRecordDoctorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientRecordActionsResponse {
  @JsonKey(name: 'canDownloadPdf')
  final bool? canDownloadPdf;
  @JsonKey(name: 'downloadPdfUrl')
  final String? downloadPdfUrl;
  @JsonKey(name: 'canBookFollowUp')
  final bool? canBookFollowUp;
  @JsonKey(name: 'doctorId')
  final String? doctorId;

  PatientRecordActionsResponse({
    this.canDownloadPdf,
    this.downloadPdfUrl,
    this.canBookFollowUp,
    this.doctorId,
  });

  factory PatientRecordActionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordActionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRecordActionsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientRecordMedicationResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'drugNameAr')
  final String? drugNameAr;
  @JsonKey(name: 'drugNameEn')
  final String? drugNameEn;
  @JsonKey(name: 'formAr')
  final String? formAr;
  @JsonKey(name: 'doseAr')
  final String? doseAr;
  @JsonKey(name: 'frequencyAr')
  final String? frequencyAr;
  @JsonKey(name: 'timingAr')
  final String? timingAr;
  @JsonKey(name: 'durationAr')
  final String? durationAr;
  @JsonKey(name: 'noteAr')
  final String? noteAr;

  PatientRecordMedicationResponse({
    this.id,
    this.drugNameAr,
    this.drugNameEn,
    this.formAr,
    this.doseAr,
    this.frequencyAr,
    this.timingAr,
    this.durationAr,
    this.noteAr,
  });

  factory PatientRecordMedicationResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordMedicationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientRecordMedicationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientRecordDiagnosisResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'descriptionAr')
  final String? descriptionAr;
  @JsonKey(name: 'descriptionEn')
  final String? descriptionEn;

  PatientRecordDiagnosisResponse({
    this.id,
    this.code,
    this.descriptionAr,
    this.descriptionEn,
  });

  factory PatientRecordDiagnosisResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordDiagnosisResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRecordDiagnosisResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientRequestedTestResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'titleAr')
  final String? titleAr;

  PatientRequestedTestResponse({this.id, this.titleAr});

  factory PatientRequestedTestResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientRequestedTestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRequestedTestResponseToJson(this);
}
