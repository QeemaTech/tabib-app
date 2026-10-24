import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class DoctorResetPasswordResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorResetPasswordData? data;

  DoctorResetPasswordResponse({this.success, this.data});

  factory DoctorResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorResetPasswordResponseToJson(this);
}

@JsonSerializable()
class DoctorResetPasswordData {
  @JsonKey(name: 'message')
  final String? message;

  DoctorResetPasswordData({this.message});

  factory DoctorResetPasswordData.fromJson(Map<String, dynamic> json) =>
      _$DoctorResetPasswordDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorResetPasswordDataToJson(this);
}
