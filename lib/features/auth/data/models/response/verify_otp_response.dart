import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final VerifyOtpData? data;

  VerifyOtpResponse({
    this.success,
    this.data,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);
}

@JsonSerializable()
class VerifyOtpData {
  @JsonKey(name: 'accessToken')
  final String? accessToken;
  @JsonKey(name: 'refreshToken')
  final String? refreshToken;
  @JsonKey(name: 'user')
  final AuthUser? user;

  VerifyOtpData({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDataFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpDataToJson(this);
}

@JsonSerializable()
class AuthUser {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'roleAr')
  final String? roleAr;
  @JsonKey(name: 'isVerified')
  final bool? isVerified;
  @JsonKey(name: 'preferredLocale')
  final String? preferredLocale;
  @JsonKey(name: 'permissions')
  final List<String>? permissions;

  AuthUser({
    this.id,
    this.phone,
    this.email,
    this.role,
    this.roleAr,
    this.isVerified,
    this.preferredLocale,
    this.permissions,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
