import 'package:json_annotation/json_annotation.dart';

part 'doctor_patients_response.g.dart';

@JsonSerializable()
class DoctorPatientsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<DoctorPatientItemResponse>? data;

  DoctorPatientsResponse({
    this.success,
    this.data,
  });

  factory DoctorPatientsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorPatientsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPatientsResponseToJson(this);
}

@JsonSerializable()
class DoctorPatientItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'displayId')
  final String? displayId;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'age')
  final int? age;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'genderLabelAr')
  final String? genderLabelAr;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'statusLabelAr')
  final String? statusLabelAr;
  @JsonKey(name: 'lastVisit')
  final DoctorPatientLastVisitResponse? lastVisit;
  @JsonKey(name: 'hasReport')
  final bool? hasReport;

  DoctorPatientItemResponse({
    this.id,
    this.displayId,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.age,
    this.gender,
    this.genderLabelAr,
    this.status,
    this.statusLabelAr,
    this.lastVisit,
    this.hasReport,
  });

  factory DoctorPatientItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorPatientItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPatientItemResponseToJson(this);
}

@JsonSerializable()
class DoctorPatientLastVisitResponse {
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'startTime')
  final String? startTime;

  DoctorPatientLastVisitResponse({
    this.appointmentId,
    this.date,
    this.startTime,
  });

  factory DoctorPatientLastVisitResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorPatientLastVisitResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorPatientLastVisitResponseToJson(this);
}
