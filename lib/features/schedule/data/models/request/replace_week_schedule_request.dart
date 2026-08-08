import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/schedule/data/models/request/update_day_schedule_request.dart';

part 'replace_week_schedule_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ReplaceWeekScheduleRequest {
  @JsonKey(name: 'schedule')
  final List<ReplaceWeekDayRequest> schedule;

  ReplaceWeekScheduleRequest({required this.schedule});

  factory ReplaceWeekScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$ReplaceWeekScheduleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReplaceWeekScheduleRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReplaceWeekDayRequest {
  @JsonKey(name: 'dayOfWeek')
  final int dayOfWeek;
  @JsonKey(name: 'isActive')
  final bool isActive;
  @JsonKey(name: 'slots')
  final List<ScheduleSlotRequest> slots;

  ReplaceWeekDayRequest({
    required this.dayOfWeek,
    required this.isActive,
    required this.slots,
  });

  factory ReplaceWeekDayRequest.fromJson(Map<String, dynamic> json) =>
      _$ReplaceWeekDayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReplaceWeekDayRequestToJson(this);
}
