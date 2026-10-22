import 'package:json_annotation/json_annotation.dart';

part 'cancel_appointment_response.g.dart';

@JsonSerializable()
class CancelAppointmentResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final CancelAppointmentData? data;

  CancelAppointmentResponse({
    this.success,
    this.data,
  });

  factory CancelAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CancelAppointmentResponseToJson(this);
}

@JsonSerializable()
class CancelAppointmentData {
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
  final CancelAppointmentDoctorData? doctor;
  @JsonKey(name: 'patient')
  final CancelAppointmentPatientData? patient;

  CancelAppointmentData({
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
    this.patient,
  });

  factory CancelAppointmentData.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$CancelAppointmentDataToJson(this);
}

@JsonSerializable()
class CancelAppointmentDoctorData {
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

  CancelAppointmentDoctorData({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.consultationFee,
    this.specialties,
  });

  factory CancelAppointmentDoctorData.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentDoctorDataFromJson(json);

  Map<String, dynamic> toJson() => _$CancelAppointmentDoctorDataToJson(this);
}

@JsonSerializable()
class CancelAppointmentPatientData {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;

  CancelAppointmentPatientData({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
  });

  factory CancelAppointmentPatientData.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentPatientDataFromJson(json);

  Map<String, dynamic> toJson() => _$CancelAppointmentPatientDataToJson(this);
}
