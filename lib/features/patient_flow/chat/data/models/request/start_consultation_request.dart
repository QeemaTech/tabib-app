import 'package:json_annotation/json_annotation.dart';

part 'start_consultation_request.g.dart';

@JsonSerializable()
class PatientStartConsultationRequest {
  @JsonKey(name: 'type')
  final String type;

  PatientStartConsultationRequest({required this.type});

  factory PatientStartConsultationRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientStartConsultationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientStartConsultationRequestToJson(this);
}
