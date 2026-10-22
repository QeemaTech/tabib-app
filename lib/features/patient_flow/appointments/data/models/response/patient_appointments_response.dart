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

@JsonSerializable(explicitToJson: true)
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
  @JsonKey(name: 'bookingPrice')
  final num? bookingPrice;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'durationChatHours')
  final num? durationChatHours;
  @JsonKey(name: 'durationCallMinutes')
  final num? durationCallMinutes;
  @JsonKey(name: 'complaint')
  final String? complaint;
  @JsonKey(name: 'symptoms')
  final String? symptoms;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'cancelReason')
  final String? cancelReason;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'sessionStartsAt')
  final String? sessionStartsAt;
  @JsonKey(name: 'accessWindows')
  final PatientAppointmentAccessWindowsResponse? accessWindows;
  @JsonKey(name: 'permissions')
  final PatientAppointmentPermissionsResponse? permissions;
  @JsonKey(name: 'activeConsultation')
  final Map<String, dynamic>? activeConsultation;
  @JsonKey(name: 'activeCall')
  final Map<String, dynamic>? activeCall;
  @JsonKey(name: 'doctor')
  final PatientAppointmentDoctorResponse? doctor;
  @JsonKey(name: 'actions')
  final PatientAppointmentActionsResponse? actions;

  PatientAppointmentItemResponse({
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
    this.complaint,
    this.symptoms,
    this.notes,
    this.cancelReason,
    this.createdAt,
    this.sessionStartsAt,
    this.accessWindows,
    this.permissions,
    this.activeConsultation,
    this.activeCall,
    this.doctor,
    this.actions,
  });

  factory PatientAppointmentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientAppointmentItemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentItemResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAppointmentAccessWindowsResponse {
  @JsonKey(name: 'sessionStartsAt')
  final String? sessionStartsAt;
  @JsonKey(name: 'chat')
  final PatientAppointmentChatWindowResponse? chat;
  @JsonKey(name: 'call')
  final PatientAppointmentCallWindowResponse? call;

  PatientAppointmentAccessWindowsResponse({
    this.sessionStartsAt,
    this.chat,
    this.call,
  });

  factory PatientAppointmentAccessWindowsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientAppointmentAccessWindowsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentAccessWindowsResponseToJson(this);
}

@JsonSerializable()
class PatientAppointmentChatWindowResponse {
  @JsonKey(name: 'availableFrom')
  final String? availableFrom;
  @JsonKey(name: 'availableUntil')
  final String? availableUntil;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'remainingHours')
  final num? remainingHours;

  PatientAppointmentChatWindowResponse({
    this.availableFrom,
    this.availableUntil,
    this.isActive,
    this.remainingHours,
  });

  factory PatientAppointmentChatWindowResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientAppointmentChatWindowResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentChatWindowResponseToJson(this);
}

@JsonSerializable()
class PatientAppointmentCallWindowResponse {
  @JsonKey(name: 'availableFrom')
  final String? availableFrom;
  @JsonKey(name: 'availableUntil')
  final String? availableUntil;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'durationMinutes')
  final num? durationMinutes;
  @JsonKey(name: 'usedSeconds')
  final num? usedSeconds;
  @JsonKey(name: 'remainingSeconds')
  final num? remainingSeconds;

  PatientAppointmentCallWindowResponse({
    this.availableFrom,
    this.availableUntil,
    this.isActive,
    this.durationMinutes,
    this.usedSeconds,
    this.remainingSeconds,
  });

  factory PatientAppointmentCallWindowResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientAppointmentCallWindowResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentCallWindowResponseToJson(this);
}

@JsonSerializable()
class PatientAppointmentPermissionsResponse {
  @JsonKey(name: 'chat')
  final bool? chat;
  @JsonKey(name: 'call')
  final bool? call;

  PatientAppointmentPermissionsResponse({
    this.chat,
    this.call,
  });

  factory PatientAppointmentPermissionsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientAppointmentPermissionsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentPermissionsResponseToJson(this);
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
  @JsonKey(name: 'bookingPrice')
  final num? bookingPrice;
  @JsonKey(name: 'specialties')
  final List<String>? specialties;

  PatientAppointmentDoctorResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.bookingPrice,
    this.specialties,
  });

  factory PatientAppointmentDoctorResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientAppointmentDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentDoctorResponseToJson(this);
}

@JsonSerializable()
class PatientAppointmentActionsResponse {
  @JsonKey(name: 'canCancel')
  final bool? canCancel;
  @JsonKey(name: 'canPay')
  final bool? canPay;
  @JsonKey(name: 'canAccessChat')
  final bool? canAccessChat;
  @JsonKey(name: 'canAccessCall')
  final bool? canAccessCall;
  @JsonKey(name: 'canReview')
  final bool? canReview;

  PatientAppointmentActionsResponse({
    this.canCancel,
    this.canPay,
    this.canAccessChat,
    this.canAccessCall,
    this.canReview,
  });

  factory PatientAppointmentActionsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientAppointmentActionsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentActionsResponseToJson(this);
}
