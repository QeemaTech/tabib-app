import 'package:json_annotation/json_annotation.dart';

part 'doctor_dashboard_response.g.dart';

@JsonSerializable()
class DoctorDashboardResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorDashboardDataResponse? data;

  DoctorDashboardResponse({
    this.success,
    this.data,
  });

  factory DoctorDashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDashboardResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardDataResponse {
  @JsonKey(name: 'todayAppointments')
  final List<DoctorDashboardAppointmentResponse>? todayAppointments;
  @JsonKey(name: 'pendingRequests')
  final List<DoctorDashboardAppointmentResponse>? pendingRequests;
  @JsonKey(name: 'stats')
  final DoctorDashboardStatsResponse? stats;

  DoctorDashboardDataResponse({
    this.todayAppointments,
    this.pendingRequests,
    this.stats,
  });

  factory DoctorDashboardDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDashboardDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDashboardDataResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardStatsResponse {
  @JsonKey(name: 'todayCount')
  final int? todayCount;
  @JsonKey(name: 'weekCount')
  final int? weekCount;
  @JsonKey(name: 'completedCount')
  final int? completedCount;
  @JsonKey(name: 'totalCompletedCount')
  final int? totalCompletedCount;
  @JsonKey(name: 'pendingCount')
  final int? pendingCount;
  @JsonKey(name: 'rating')
  final num? rating;
  @JsonKey(name: 'ratingCount')
  final int? ratingCount;
  @JsonKey(name: 'earnings')
  final num? earnings;

  DoctorDashboardStatsResponse({
    this.todayCount,
    this.weekCount,
    this.completedCount,
    this.totalCompletedCount,
    this.pendingCount,
    this.rating,
    this.ratingCount,
    this.earnings,
  });

  factory DoctorDashboardStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDashboardStatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDashboardStatsResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardAppointmentResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'consultationType')
  final String? consultationType;
  @JsonKey(name: 'bookingPrice')
  final num? bookingPrice;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'sessionStartsAt')
  final String? sessionStartsAt;
  @JsonKey(name: 'durationChatHours')
  final int? durationChatHours;
  @JsonKey(name: 'durationCallMinutes')
  final int? durationCallMinutes;
  @JsonKey(name: 'accessWindows')
  final DoctorDashboardAccessWindowsResponse? accessWindows;
  @JsonKey(name: 'actions')
  final DoctorDashboardActionsResponse? actions;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'patient')
  final DoctorDashboardPatientResponse? patient;

  DoctorDashboardAppointmentResponse({
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.consultationType,
    this.bookingPrice,
    this.currency,
    this.sessionStartsAt,
    this.durationChatHours,
    this.durationCallMinutes,
    this.accessWindows,
    this.actions,
    this.createdAt,
    this.patient,
  });

  factory DoctorDashboardAppointmentResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorDashboardAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorDashboardAppointmentResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardPatientResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;

  DoctorDashboardPatientResponse({
    this.id,
    this.fullNameAr,
    this.avatarUrl,
    this.phone,
    this.countryCode,
  });

  factory DoctorDashboardPatientResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDashboardPatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDashboardPatientResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardAccessWindowsResponse {
  @JsonKey(name: 'chat')
  final DoctorDashboardChatAccessResponse? chat;
  @JsonKey(name: 'call')
  final DoctorDashboardCallAccessResponse? call;

  DoctorDashboardAccessWindowsResponse({
    this.chat,
    this.call,
  });

  factory DoctorDashboardAccessWindowsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorDashboardAccessWindowsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorDashboardAccessWindowsResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardChatAccessResponse {
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'remainingHours')
  final num? remainingHours;

  DoctorDashboardChatAccessResponse({
    this.isActive,
    this.remainingHours,
  });

  factory DoctorDashboardChatAccessResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorDashboardChatAccessResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorDashboardChatAccessResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardCallAccessResponse {
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'durationMinutes')
  final int? durationMinutes;
  @JsonKey(name: 'usedSeconds')
  final int? usedSeconds;
  @JsonKey(name: 'remainingSeconds')
  final int? remainingSeconds;

  DoctorDashboardCallAccessResponse({
    this.isActive,
    this.durationMinutes,
    this.usedSeconds,
    this.remainingSeconds,
  });

  factory DoctorDashboardCallAccessResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorDashboardCallAccessResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorDashboardCallAccessResponseToJson(this);
}

@JsonSerializable()
class DoctorDashboardActionsResponse {
  @JsonKey(name: 'canAccessChat')
  final bool? canAccessChat;
  @JsonKey(name: 'canAccessCall')
  final bool? canAccessCall;

  DoctorDashboardActionsResponse({
    this.canAccessChat,
    this.canAccessCall,
  });

  factory DoctorDashboardActionsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDashboardActionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDashboardActionsResponseToJson(this);
}
