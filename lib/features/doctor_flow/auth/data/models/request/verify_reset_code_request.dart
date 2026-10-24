import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_request.g.dart';

@JsonSerializable()
class DoctorVerifyResetCodeRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'code')
  final String? code;

  DoctorVerifyResetCodeRequest({this.phone, this.countryCode, this.code});

  factory DoctorVerifyResetCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorVerifyResetCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorVerifyResetCodeRequestToJson(this);
}
