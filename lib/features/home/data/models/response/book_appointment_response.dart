import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_response.g.dart';

@JsonSerializable()
class BookAppointmentResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final BookAppointmentData? data;

  BookAppointmentResponse({
    this.success,
    this.data,
  });

  factory BookAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentResponseToJson(this);
}

@JsonSerializable()
class BookAppointmentData {
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
  @JsonKey(name: 'quotedFee')
  final num? quotedFee;
  @JsonKey(name: 'durationMinutes')
  final int? durationMinutes;
  @JsonKey(name: 'platformFeePercent')
  final num? platformFeePercent;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'cancelReason')
  final String? cancelReason;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'doctor')
  final BookAppointmentDoctorData? doctor;

  BookAppointmentData({
    this.id,
    this.status,
    this.date,
    this.startTime,
    this.endTime,
    this.consultationType,
    this.quotedFee,
    this.durationMinutes,
    this.platformFeePercent,
    this.notes,
    this.cancelReason,
    this.createdAt,
    this.doctor,
  });

  factory BookAppointmentData.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentDataToJson(this);
}

@JsonSerializable()
class BookAppointmentDoctorData {
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

  BookAppointmentDoctorData({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.consultationFee,
    this.specialties,
  });

  factory BookAppointmentDoctorData.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentDoctorDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentDoctorDataToJson(this);
}
