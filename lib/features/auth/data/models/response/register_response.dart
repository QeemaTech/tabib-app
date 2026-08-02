import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "data")
  final Data? data;

  RegisterResponse ({
    this.success,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterResponseToJson(this);
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


