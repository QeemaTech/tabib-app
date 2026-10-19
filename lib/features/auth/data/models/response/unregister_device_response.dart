import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/auth/data/models/response/register_device_response.dart';

part 'unregister_device_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UnregisterDeviceResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final UnregisterDeviceData? data;
  @JsonKey(name: 'meta')
  final DevicePageMeta? meta;

  UnregisterDeviceResponse({
    this.success,
    this.data,
    this.meta,
  });

  factory UnregisterDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$UnregisterDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnregisterDeviceResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UnregisterDeviceData {
  @JsonKey(name: 'cleared')
  final int? cleared;

  UnregisterDeviceData({this.cleared});

  factory UnregisterDeviceData.fromJson(Map<String, dynamic> json) =>
      _$UnregisterDeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$UnregisterDeviceDataToJson(this);
}
