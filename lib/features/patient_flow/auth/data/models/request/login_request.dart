import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class PatientLoginRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'role')
  final String? role;

  PatientLoginRequest({
    this.phone,
    this.countryCode,
    this.role,
  });

  factory PatientLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientLoginRequestToJson(this);
}
