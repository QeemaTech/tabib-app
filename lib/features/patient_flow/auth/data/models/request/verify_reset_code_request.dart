import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_request.g.dart';

@JsonSerializable()
class PatientVerifyResetCodeRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'code')
  final String? code;

  PatientVerifyResetCodeRequest({this.phone, this.countryCode, this.code});

  factory PatientVerifyResetCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientVerifyResetCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientVerifyResetCodeRequestToJson(this);
}
