import 'package:json_annotation/json_annotation.dart';

part 'reject_appointment_request.g.dart';

@JsonSerializable()
class RejectAppointmentRequest {
  @JsonKey(name: 'reason')
  final String reason;

  RejectAppointmentRequest({required this.reason});

  factory RejectAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$RejectAppointmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RejectAppointmentRequestToJson(this);
}
