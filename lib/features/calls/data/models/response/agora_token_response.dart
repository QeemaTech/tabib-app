import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/calls/data/models/json_scalars.dart';

part 'agora_token_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AgoraTokenResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final AgoraTokenDataResponse? data;

  AgoraTokenResponse({
    this.success,
    this.data,
  });

  factory AgoraTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AgoraTokenDataResponse {
  @JsonKey(name: 'token', fromJson: readJsonString)
  final String? token;
  @JsonKey(name: 'channelName', fromJson: readJsonString)
  final String? channelName;
  @JsonKey(name: 'appId', fromJson: readJsonString)
  final String? appId;
  @JsonKey(name: 'expiresAt', fromJson: readJsonString)
  final String? expiresAt;
  @JsonKey(name: 'uid')
  final int? uid;

  AgoraTokenDataResponse({
    this.token,
    this.channelName,
    this.appId,
    this.expiresAt,
    this.uid,
  });

  factory AgoraTokenDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenDataResponseToJson(this);
}
