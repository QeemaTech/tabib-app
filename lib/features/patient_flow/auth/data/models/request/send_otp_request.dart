import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request.g.dart';

@JsonSerializable()
class PatientSendOtpRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'role')
  final String? role;

  PatientSendOtpRequest({this.phone, this.countryCode, this.role});

  factory PatientSendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientSendOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientSendOtpRequestToJson(this);
}
