import 'package:json_annotation/json_annotation.dart';

part 'register_device_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorRegisterDeviceResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final RegisterDeviceData? data;
  @JsonKey(name: 'meta')
  final DevicePageMeta? meta;

  DoctorRegisterDeviceResponse({
    this.success,
    this.data,
    this.meta,
  });

  factory DoctorRegisterDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorRegisterDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorRegisterDeviceResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisterDeviceData {
  @JsonKey(name: 'deviceId')
  final String? deviceId;
  @JsonKey(name: 'platform')
  final String? platform;

  RegisterDeviceData({
    this.deviceId,
    this.platform,
  });

  factory RegisterDeviceData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDeviceDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DevicePageMeta {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'totalPages')
  final int? totalPages;

  DevicePageMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory DevicePageMeta.fromJson(Map<String, dynamic> json) =>
      _$DevicePageMetaFromJson(json);

  Map<String, dynamic> toJson() => _$DevicePageMetaToJson(this);
}
