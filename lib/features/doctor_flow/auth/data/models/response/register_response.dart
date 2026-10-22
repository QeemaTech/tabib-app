import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class DoctorRegisterResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "data")
  final Data? data;

  DoctorRegisterResponse ({
    this.success,
    this.data,
  });

  factory DoctorRegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$DoctorRegisterResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DoctorRegisterResponseToJson(this);
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


