import 'package:json_annotation/json_annotation.dart';

part 'agora_token_request.g.dart';

@JsonSerializable()
class PatientAgoraTokenRequest {
  @JsonKey(name: 'channelName')
  final String channelName;
  @JsonKey(name: 'role')
  final String role;

  PatientAgoraTokenRequest({
    required this.channelName,
    this.role = 'publisher',
  });

  factory PatientAgoraTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientAgoraTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAgoraTokenRequestToJson(this);
}
