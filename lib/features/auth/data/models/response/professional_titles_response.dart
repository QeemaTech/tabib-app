import 'package:json_annotation/json_annotation.dart';

part 'professional_titles_response.g.dart';

@JsonSerializable()
class ProfessionalTitlesResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<ProfessionalTitleItemResponse>? data;

  ProfessionalTitlesResponse({this.success, this.data});

  factory ProfessionalTitlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalTitlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionalTitlesResponseToJson(this);
}

@JsonSerializable()
class ProfessionalTitleItemResponse {
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;

  ProfessionalTitleItemResponse({
    this.value,
    this.nameAr,
    this.nameEn,
  });

  factory ProfessionalTitleItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalTitleItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionalTitleItemResponseToJson(this);
}
