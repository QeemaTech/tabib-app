import 'package:json_annotation/json_annotation.dart';

part 'doctor_appointments_response.g.dart';

@JsonSerializable()
class DoctorAppointmentsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<DoctorAppointmentItemResponse>? data;

  DoctorAppointmentsResponse({
    this.success,
    this.data,
  });

  factory DoctorAppointmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentsResponseToJson(this);
}

@JsonSerializable()
class DoctorAppointmentDetailsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorAppointmentItemResponse? data;

  DoctorAppointmentDetailsResponse({
    this.success,
    this.data,
  });

  factory DoctorAppointmentDetailsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorAppointmentDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorAppointmentDetailsResponseToJson(this);
}

@JsonSerializable()
class DoctorAppointmentItemResponse {
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
  @JsonKey(name: 'bookingPrice')
  final num? bookingPrice;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'durationChatHours')
  final int? durationChatHours;
  @JsonKey(name: 'durationCallMinutes')
  final int? durationCallMinutes;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'cancelReason')
  final String? cancelReason;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'sessionStartsAt')
  final String? sessionStartsAt;
  @JsonKey(name: 'accessWindows')
  final DoctorAppointmentAccessWindowsResponse? accessWindows;
  @JsonKey(name: 'patient')
  final DoctorAppointmentPatientResponse? patient;
  @JsonKey(name: 'actions')
  final DoctorAppointmentActionsResponse? actions;
  @JsonKey(name: 'cancelledBy')
  final String? cancelledBy;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  DoctorAppointmentItemResponse({
    this.id,
    this.status,
    this.date,
    this.startTime,
    this.endTime,
    this.consultationType,
    this.bookingPrice,
    this.currency,
    this.durationChatHours,
    this.durationCallMinutes,
    this.notes,
    this.cancelReason,
    this.createdAt,
    this.sessionStartsAt,
    this.accessWindows,
    this.patient,
    this.actions,
    this.cancelledBy,
    this.updatedAt,
  });

  factory DoctorAppointmentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentItemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorAppointmentItemResponseToJson(this);
}

@JsonSerializable()
class DoctorAppointmentPatientResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'email')
  final String? email;

  DoctorAppointmentPatientResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.phone,
    this.countryCode,
    this.email,
  });

  factory DoctorAppointmentPatientResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorAppointmentPatientResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorAppointmentPatientResponseToJson(this);
}

@JsonSerializable()
class DoctorAppointmentAccessWindowsResponse {
  @JsonKey(name: 'sessionStartsAt')
  final String? sessionStartsAt;
  @JsonKey(name: 'chat')
  final DoctorAppointmentChatAccessResponse? chat;
  @JsonKey(name: 'call')
  final DoctorAppointmentCallAccessResponse? call;

  DoctorAppointmentAccessWindowsResponse({
    this.sessionStartsAt,
    this.chat,
    this.call,
  });

  factory DoctorAppointmentAccessWindowsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorAppointmentAccessWindowsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorAppointmentAccessWindowsResponseToJson(this);
}

@JsonSerializable()
class DoctorAppointmentChatAccessResponse {
  @JsonKey(name: 'availableFrom')
  final String? availableFrom;
  @JsonKey(name: 'availableUntil')
  final String? availableUntil;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'remainingHours')
  final num? remainingHours;

  DoctorAppointmentChatAccessResponse({
    this.availableFrom,
    this.availableUntil,
    this.isActive,
    this.remainingHours,
  });

  factory DoctorAppointmentChatAccessResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorAppointmentChatAccessResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorAppointmentChatAccessResponseToJson(this);
}

@JsonSerializable()
class DoctorAppointmentCallAccessResponse {
  @JsonKey(name: 'availableFrom')
  final String? availableFrom;
  @JsonKey(name: 'availableUntil')
  final String? availableUntil;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'durationMinutes')
  final int? durationMinutes;
  @JsonKey(name: 'usedSeconds')
  final int? usedSeconds;
  @JsonKey(name: 'remainingSeconds')
  final int? remainingSeconds;

  DoctorAppointmentCallAccessResponse({
    this.availableFrom,
    this.availableUntil,
    this.isActive,
    this.durationMinutes,
    this.usedSeconds,
    this.remainingSeconds,
  });

  factory DoctorAppointmentCallAccessResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorAppointmentCallAccessResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorAppointmentCallAccessResponseToJson(this);
}

@JsonSerializable()
class DoctorAppointmentActionsResponse {
  @JsonKey(name: 'canAccessChat')
  final bool? canAccessChat;
  @JsonKey(name: 'canAccessCall')
  final bool? canAccessCall;

  DoctorAppointmentActionsResponse({
    this.canAccessChat,
    this.canAccessCall,
  });

  factory DoctorAppointmentActionsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorAppointmentActionsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorAppointmentActionsResponseToJson(this);
}
