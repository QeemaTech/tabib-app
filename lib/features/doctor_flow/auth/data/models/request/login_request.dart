import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class DoctorLoginRequest {
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'role')
  final String? role;

  DoctorLoginRequest({this.phone, this.countryCode, this.password, this.role});

  factory DoctorLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorLoginRequestToJson(this);
}
