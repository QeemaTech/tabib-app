import 'package:json_annotation/json_annotation.dart';

part 'end_call_response.g.dart';

@JsonSerializable(explicitToJson: true)
class EndCallResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final EndCallDataResponse? data;

  EndCallResponse({
    this.success,
    this.data,
  });

  factory EndCallResponse.fromJson(Map<String, dynamic> json) =>
      _$EndCallResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EndCallResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EndCallDataResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'channelName')
  final String? channelName;
  @JsonKey(name: 'callType')
  final String? callType;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'startedAt')
  final String? startedAt;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'durationSeconds')
  final int? durationSeconds;

  EndCallDataResponse({
    this.id,
    this.appointmentId,
    this.channelName,
    this.callType,
    this.status,
    this.startedAt,
    this.token,
    this.durationSeconds,
  });

  factory EndCallDataResponse.fromJson(Map<String, dynamic> json) =>
      _$EndCallDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EndCallDataResponseToJson(this);
}
