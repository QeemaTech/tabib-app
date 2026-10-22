import 'package:json_annotation/json_annotation.dart';

part 'book_appointment_request.g.dart';

@JsonSerializable()
class BookAppointmentRequest {
  @JsonKey(name: 'doctorId')
  final String? doctorId;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'consultationType')
  final String? consultationType;

  BookAppointmentRequest({
    this.doctorId,
    this.date,
    this.startTime,
    this.consultationType,
  });

  factory BookAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentRequestToJson(this);
}
