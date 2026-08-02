import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
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

  RegisterRequest ({
    this.fullName,
    this.phone,
    this.countryCode,
    this.email,
    this.preferredLanguage,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return _$RegisterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterRequestToJson(this);
  }
}


