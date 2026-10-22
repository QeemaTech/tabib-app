import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class DoctorVerifyOtpRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'role')
  final String? role;

  DoctorVerifyOtpRequest({
    this.phone,
    this.countryCode,
    this.code,
    this.role,
  });

  factory DoctorVerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorVerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorVerifyOtpRequestToJson(this);
}
