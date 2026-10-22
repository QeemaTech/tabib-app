import 'package:json_annotation/json_annotation.dart';

part 'register_device_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientRegisterDeviceRequest {
  @JsonKey(name: 'fcmToken')
  final String? fcmToken;
  @JsonKey(name: 'platform')
  final String? platform;
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  PatientRegisterDeviceRequest({
    this.fcmToken,
    this.platform,
    this.deviceName,
  });

  factory PatientRegisterDeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientRegisterDeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRegisterDeviceRequestToJson(this);
}
