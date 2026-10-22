import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class PatientRegisterRequest {
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "countryCode")
  final String? countryCode;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "preferredLanguage")
  final String? preferredLanguage;

  PatientRegisterRequest ({
    this.fullName,
    this.phone,
    this.countryCode,
    this.email,
    this.preferredLanguage,
  });

  factory PatientRegisterRequest.fromJson(Map<String, dynamic> json) {
    return _$PatientRegisterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PatientRegisterRequestToJson(this);
  }
}


