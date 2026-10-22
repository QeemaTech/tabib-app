import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notifications_response.dart';

part 'notification_read_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorNotificationReadResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final NotificationItemResponse? data;

  DoctorNotificationReadResponse({this.success, this.data});

  factory DoctorNotificationReadResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorNotificationReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorNotificationReadResponseToJson(this);
}
