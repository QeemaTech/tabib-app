import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request.g.dart';

@JsonSerializable()
class DoctorSendOtpRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'role')
  final String? role;

  DoctorSendOtpRequest({this.phone, this.countryCode, this.role});

  factory DoctorSendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorSendOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSendOtpRequestToJson(this);
}
