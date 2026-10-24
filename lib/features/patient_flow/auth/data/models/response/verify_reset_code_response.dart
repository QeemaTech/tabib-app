import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_response.g.dart';

@JsonSerializable()
class PatientVerifyResetCodeResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientVerifyResetCodeData? data;

  PatientVerifyResetCodeResponse({this.success, this.data});

  factory PatientVerifyResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientVerifyResetCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientVerifyResetCodeResponseToJson(this);
}

@JsonSerializable()
class PatientVerifyResetCodeData {
  @JsonKey(name: 'verified')
  final bool? verified;
  @JsonKey(name: 'resetToken')
  final String? resetToken;
  @JsonKey(name: 'message')
  final String? message;

  PatientVerifyResetCodeData({this.verified, this.resetToken, this.message});

  factory PatientVerifyResetCodeData.fromJson(Map<String, dynamic> json) =>
      _$PatientVerifyResetCodeDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientVerifyResetCodeDataToJson(this);
}
