import 'package:json_annotation/json_annotation.dart';

part 'register_device_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterDeviceRequest {
  @JsonKey(name: 'fcmToken')
  final String? fcmToken;
  @JsonKey(name: 'platform')
  final String? platform;
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  RegisterDeviceRequest({
    this.fcmToken,
    this.platform,
    this.deviceName,
  });

  factory RegisterDeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDeviceRequestToJson(this);
}
