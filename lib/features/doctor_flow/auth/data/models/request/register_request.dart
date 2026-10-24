import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class DoctorRegisterRequest {
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "countryCode")
  final String? countryCode;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "preferredLanguage")
  final String? preferredLanguage;

  DoctorRegisterRequest({
    this.fullName,
    this.phone,
    this.countryCode,
    this.email,
    this.password,
    this.preferredLanguage,
  });

  factory DoctorRegisterRequest.fromJson(Map<String, dynamic> json) {
    return _$DoctorRegisterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DoctorRegisterRequestToJson(this);
  }
}
