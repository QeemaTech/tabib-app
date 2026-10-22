import 'package:json_annotation/json_annotation.dart';

part 'start_consultation_request.g.dart';

@JsonSerializable()
class DoctorStartConsultationRequest {
  @JsonKey(name: 'type')
  final String type;

  DoctorStartConsultationRequest({required this.type});

  factory DoctorStartConsultationRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorStartConsultationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorStartConsultationRequestToJson(this);
}
