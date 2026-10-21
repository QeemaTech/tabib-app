import 'package:json_annotation/json_annotation.dart';

part 'mark_all_read_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MarkAllReadResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final MarkAllReadDataResponse? data;

  MarkAllReadResponse({this.success, this.data});

  factory MarkAllReadResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkAllReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarkAllReadResponseToJson(this);
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
