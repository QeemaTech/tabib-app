import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_response.g.dart';

@JsonSerializable()
class DoctorVerifyResetCodeResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorVerifyResetCodeData? data;

  DoctorVerifyResetCodeResponse({this.success, this.data});

  factory DoctorVerifyResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorVerifyResetCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorVerifyResetCodeResponseToJson(this);
}

@JsonSerializable()
class DoctorVerifyResetCodeData {
  @JsonKey(name: 'verified')
  final bool? verified;
  @JsonKey(name: 'resetToken')
  final String? resetToken;
  @JsonKey(name: 'message')
  final String? message;

  DoctorVerifyResetCodeData({this.verified, this.resetToken, this.message});

  factory DoctorVerifyResetCodeData.fromJson(Map<String, dynamic> json) =>
      _$DoctorVerifyResetCodeDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorVerifyResetCodeDataToJson(this);
}
