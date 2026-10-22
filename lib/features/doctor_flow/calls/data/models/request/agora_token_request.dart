import 'package:json_annotation/json_annotation.dart';

part 'agora_token_request.g.dart';

@JsonSerializable()
class DoctorAgoraTokenRequest {
  @JsonKey(name: 'channelName')
  final String channelName;
  @JsonKey(name: 'role')
  final String role;

  DoctorAgoraTokenRequest({
    required this.channelName,
    this.role = 'publisher',
  });

  factory DoctorAgoraTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorAgoraTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAgoraTokenRequestToJson(this);
}
