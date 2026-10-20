import 'package:json_annotation/json_annotation.dart';

part 'agora_token_request.g.dart';

@JsonSerializable()
class AgoraTokenRequest {
  @JsonKey(name: 'channelName')
  final String channelName;
  @JsonKey(name: 'role')
  final String role;

  AgoraTokenRequest({
    required this.channelName,
    this.role = 'publisher',
  });

  factory AgoraTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AgoraTokenRequestToJson(this);
}
