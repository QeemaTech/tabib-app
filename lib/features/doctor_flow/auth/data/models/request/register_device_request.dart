import 'package:json_annotation/json_annotation.dart';

part 'register_device_request.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorRegisterDeviceRequest {
  @JsonKey(name: 'fcmToken')
  final String? fcmToken;
  @JsonKey(name: 'platform')
  final String? platform;
  @JsonKey(name: 'deviceName')
  final String? deviceName;

  DoctorRegisterDeviceRequest({
    this.fcmToken,
    this.platform,
    this.deviceName,
  });

  factory DoctorRegisterDeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorRegisterDeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorRegisterDeviceRequestToJson(this);
}
