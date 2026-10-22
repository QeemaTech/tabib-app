import 'package:json_annotation/json_annotation.dart';

part 'cancel_appointment_request.g.dart';

@JsonSerializable()
class CancelAppointmentRequest {
  @JsonKey(name: 'cancelReason')
  final String? cancelReason;

  CancelAppointmentRequest({this.cancelReason});

  factory CancelAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelAppointmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelAppointmentRequestToJson(this);
}
