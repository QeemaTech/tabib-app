import 'package:json_annotation/json_annotation.dart';

part 'schedule_preview_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SchedulePreviewResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final SchedulePreviewDataResponse? data;

  SchedulePreviewResponse({
    this.success,
    this.data,
  });

  factory SchedulePreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$SchedulePreviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulePreviewResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SchedulePreviewDataResponse {
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'dayOfWeek')
  final int? dayOfWeek;
  @JsonKey(name: 'slots')
  final List<SchedulePreviewSlotResponse>? slots;

  SchedulePreviewDataResponse({
    this.date,
    this.dayOfWeek,
    this.slots,
  });

  factory SchedulePreviewDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SchedulePreviewDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulePreviewDataResponseToJson(this);
}

@JsonSerializable()
class SchedulePreviewSlotResponse {
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'slotDurationMin')
  final int? slotDurationMin;

  SchedulePreviewSlotResponse({
    this.startTime,
    this.endTime,
    this.slotDurationMin,
  });

  factory SchedulePreviewSlotResponse.fromJson(Map<String, dynamic> json) =>
      _$SchedulePreviewSlotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulePreviewSlotResponseToJson(this);
}
