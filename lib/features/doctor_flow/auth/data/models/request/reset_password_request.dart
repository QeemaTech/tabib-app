import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class DoctorResetPasswordRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'resetToken')
  final String? resetToken;
  @JsonKey(name: 'newPassword')
  final String? newPassword;

  DoctorResetPasswordRequest({
    this.phone,
    this.countryCode,
    this.code,
    this.resetToken,
    this.newPassword,
  });

  factory DoctorResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorResetPasswordRequestToJson(this);
}
