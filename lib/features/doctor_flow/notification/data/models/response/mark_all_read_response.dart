import 'package:json_annotation/json_annotation.dart';

part 'mark_all_read_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorMarkAllReadResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final MarkAllReadDataResponse? data;

  DoctorMarkAllReadResponse({this.success, this.data});

  factory DoctorMarkAllReadResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorMarkAllReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorMarkAllReadResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MarkAllReadDataResponse {
  @JsonKey(name: 'updated')
  final int? updated;

  MarkAllReadDataResponse({this.updated});

  factory MarkAllReadDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkAllReadDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarkAllReadDataResponseToJson(this);
}
