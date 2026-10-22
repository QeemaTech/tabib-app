import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class PatientVerifyOtpRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'role')
  final String? role;

  PatientVerifyOtpRequest({
    this.phone,
    this.countryCode,
    this.code,
    this.role,
  });

  factory PatientVerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientVerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientVerifyOtpRequestToJson(this);
}
