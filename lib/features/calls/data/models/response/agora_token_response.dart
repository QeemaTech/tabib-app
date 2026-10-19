import 'package:json_annotation/json_annotation.dart';

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
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'channelName')
  final String? channelName;
  @JsonKey(name: 'appId')
  final String? appId;
  @JsonKey(name: 'expiresAt')
  final String? expiresAt;

  AgoraTokenDataResponse({
    this.token,
    this.channelName,
    this.appId,
    this.expiresAt,
  });

  factory AgoraTokenDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenDataResponseToJson(this);
}
