import 'package:json_annotation/json_annotation.dart';

part 'patient_appointments_response.g.dart';

@JsonSerializable()
class PatientAppointmentsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<PatientAppointmentItemResponse>? data;

  PatientAppointmentsResponse({
    this.success,
    this.data,
  });

  factory PatientAppointmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientAppointmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAppointmentsResponseToJson(this);
}

@JsonSerializable()
class PatientAppointmentItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'consultationType')
  final String? consultationType;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'cancelReason')
  final String? cancelReason;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'doctor')
  final PatientAppointmentDoctorResponse? doctor;

  PatientAppointmentItemResponse({
    this.id,
    this.status,
    this.date,
    this.startTime,
    this.endTime,
    this.consultationType,
    this.notes,
    this.cancelReason,
    this.createdAt,
    this.doctor,
  });

  factory PatientAppointmentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientAppointmentItemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentItemResponseToJson(this);
}

@JsonSerializable()
class PatientAppointmentDoctorResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'consultationFee')
  final num? consultationFee;
  @JsonKey(name: 'specialties')
  final List<String>? specialties;

  PatientAppointmentDoctorResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.consultationFee,
    this.specialties,
  });

  factory PatientAppointmentDoctorResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientAppointmentDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentDoctorResponseToJson(this);
}
