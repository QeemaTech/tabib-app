import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/calls/data/models/json_scalars.dart';

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
  @JsonKey(name: 'id', fromJson: readJsonString)
  final String? id;
  @JsonKey(name: 'appointmentId', fromJson: readJsonString)
  final String? appointmentId;
  @JsonKey(name: 'channelName', fromJson: readJsonString)
  final String? channelName;
  @JsonKey(name: 'callType', fromJson: readJsonString)
  final String? callType;
  @JsonKey(name: 'status', fromJson: readJsonString)
  final String? status;
  @JsonKey(name: 'startedAt', fromJson: readJsonString)
  final String? startedAt;
  @JsonKey(name: 'token', fromJson: readJsonString)
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
