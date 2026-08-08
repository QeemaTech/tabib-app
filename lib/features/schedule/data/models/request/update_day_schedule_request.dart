import 'package:json_annotation/json_annotation.dart';

part 'update_day_schedule_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateDayScheduleRequest {
  @JsonKey(name: 'isActive')
  final bool isActive;
  @JsonKey(name: 'slots')
  final List<ScheduleSlotRequest> slots;

  UpdateDayScheduleRequest({
    required this.isActive,
    required this.slots,
  });

  factory UpdateDayScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDayScheduleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDayScheduleRequestToJson(this);
}

@JsonSerializable()
class ScheduleSlotRequest {
  @JsonKey(name: 'startTime')
  final String startTime;
  @JsonKey(name: 'endTime')
  final String endTime;
  @JsonKey(name: 'slotDurationMin')
  final int slotDurationMin;

  ScheduleSlotRequest({
    required this.startTime,
    required this.endTime,
    required this.slotDurationMin,
  });

  factory ScheduleSlotRequest.fromJson(Map<String, dynamic> json) =>
      _$ScheduleSlotRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleSlotRequestToJson(this);
}
