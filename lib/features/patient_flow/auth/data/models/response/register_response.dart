import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class PatientRegisterResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "data")
  final Data? data;

  PatientRegisterResponse ({
    this.success,
    this.data,
  });

  factory PatientRegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$PatientRegisterResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PatientRegisterResponseToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "resendAfter")
  final int? resendAfter;
  @JsonKey(name: "expiresIn")
  final int? expiresIn;
  @JsonKey(name: "devCode")
  final String? devCode;

  Data ({
    this.resendAfter,
    this.expiresIn,
    this.devCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}


