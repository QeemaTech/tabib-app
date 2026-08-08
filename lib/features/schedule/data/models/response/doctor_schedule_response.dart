import 'package:json_annotation/json_annotation.dart';

part 'doctor_schedule_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorScheduleResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<ScheduleDayResponse>? data;

  DoctorScheduleResponse({
    this.success,
    this.data,
  });

  factory DoctorScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorScheduleResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScheduleDayResponse {
  @JsonKey(name: 'dayOfWeek')
  final int? dayOfWeek;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'slots')
  final List<ScheduleSlotResponse>? slots;

  ScheduleDayResponse({
    this.dayOfWeek,
    this.isActive,
    this.slots,
  });

  factory ScheduleDayResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDayResponseToJson(this);
}

@JsonSerializable()
class ScheduleSlotResponse {
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'slotDurationMin')
  final int? slotDurationMin;

  ScheduleSlotResponse({
    this.startTime,
    this.endTime,
    this.slotDurationMin,
  });

  factory ScheduleSlotResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleSlotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleSlotResponseToJson(this);
}
