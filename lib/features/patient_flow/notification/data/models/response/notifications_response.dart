import 'package:json_annotation/json_annotation.dart';

part 'notifications_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientNotificationsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<NotificationItemResponse>? data;
  @JsonKey(name: 'meta')
  final NotificationsMetaResponse? meta;

  PatientNotificationsResponse({this.success, this.data, this.meta});

  factory PatientNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientNotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientNotificationsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationsMetaResponse {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'unreadCount')
  final int? unreadCount;

  NotificationsMetaResponse({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.unreadCount,
  });

  factory NotificationsMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsMetaResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'titleAr')
  final String? titleAr;
  @JsonKey(name: 'bodyAr')
  final String? bodyAr;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'data')
  final NotificationDataResponse? data;
  @JsonKey(name: 'isRead')
  final bool? isRead;
  @JsonKey(name: 'sentAt')
  final String? sentAt;

  NotificationItemResponse({
    this.id,
    this.titleAr,
    this.bodyAr,
    this.type,
    this.data,
    this.isRead,
    this.sentAt,
  });

  factory NotificationItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NotificationDataResponse {
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'doctorName')
  final String? doctorName;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'patientName')
  final String? patientName;
  @JsonKey(name: 'paymentDeadline')
  final String? paymentDeadline;
  @JsonKey(name: 'deadlineMinutes')
  final int? deadlineMinutes;

  NotificationDataResponse({
    this.date,
    this.startTime,
    this.doctorName,
    this.appointmentId,
    this.patientName,
    this.paymentDeadline,
    this.deadlineMinutes,
  });

  factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataResponseToJson(this);
}
