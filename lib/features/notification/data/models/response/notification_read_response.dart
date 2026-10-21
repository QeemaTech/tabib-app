import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/notification/data/models/response/notifications_response.dart';

part 'notification_read_response.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationReadResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final NotificationItemResponse? data;

  NotificationReadResponse({this.success, this.data});

  factory NotificationReadResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationReadResponseToJson(this);
}
