import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notifications_response.dart';

part 'notification_read_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientNotificationReadResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final NotificationItemResponse? data;

  PatientNotificationReadResponse({this.success, this.data});

  factory PatientNotificationReadResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientNotificationReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientNotificationReadResponseToJson(this);
}
