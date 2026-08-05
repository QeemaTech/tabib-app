import 'package:json_annotation/json_annotation.dart';

part 'specialties_response.g.dart';

@JsonSerializable()
class SpecialtiesResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<SpecialtyItemResponse>? data;

  SpecialtiesResponse({this.success, this.data});

  factory SpecialtiesResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecialtiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialtiesResponseToJson(this);
}

@JsonSerializable()
class SpecialtyItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;
  @JsonKey(name: 'iconUrl')
  final String? iconUrl;
  @JsonKey(name: 'displayOrder')
  final int? displayOrder;
  @JsonKey(name: 'parentId')
  final String? parentId;

  SpecialtyItemResponse({
    this.id,
    this.nameAr,
    this.nameEn,
    this.iconUrl,
    this.displayOrder,
    this.parentId,
  });

  factory SpecialtyItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecialtyItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialtyItemResponseToJson(this);
}
