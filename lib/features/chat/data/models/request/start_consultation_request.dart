import 'package:json_annotation/json_annotation.dart';

part 'start_consultation_request.g.dart';

@JsonSerializable()
class StartConsultationRequest {
  @JsonKey(name: 'type')
  final String type;

  StartConsultationRequest({required this.type});

  factory StartConsultationRequest.fromJson(Map<String, dynamic> json) =>
      _$StartConsultationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StartConsultationRequestToJson(this);
}
