import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class PatientResetPasswordResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientResetPasswordData? data;

  PatientResetPasswordResponse({this.success, this.data});

  factory PatientResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResetPasswordResponseToJson(this);
}

@JsonSerializable()
class PatientResetPasswordData {
  @JsonKey(name: 'message')
  final String? message;

  PatientResetPasswordData({this.message});

  factory PatientResetPasswordData.fromJson(Map<String, dynamic> json) =>
      _$PatientResetPasswordDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResetPasswordDataToJson(this);
}
