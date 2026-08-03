import 'package:json_annotation/json_annotation.dart';

part 'doctor_availability_response.g.dart';

@JsonSerializable()
class DoctorAvailabilityResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorAvailabilityData? data;

  DoctorAvailabilityResponse({
    this.success,
    this.data,
  });

  factory DoctorAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorAvailabilityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAvailabilityResponseToJson(this);
}

@JsonSerializable()
class DoctorAvailabilityData {
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'slots')
  final List<AvailabilitySlotResponse>? slots;

  DoctorAvailabilityData({
    this.date,
    this.slots,
  });

  factory DoctorAvailabilityData.fromJson(Map<String, dynamic> json) =>
      _$DoctorAvailabilityDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAvailabilityDataToJson(this);
}

@JsonSerializable()
class AvailabilitySlotResponse {
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'available')
  final bool? available;

  AvailabilitySlotResponse({
    this.startTime,
    this.endTime,
    this.available,
  });

  factory AvailabilitySlotResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailabilitySlotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilitySlotResponseToJson(this);
}
