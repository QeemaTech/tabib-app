import 'package:json_annotation/json_annotation.dart';

part 'specialties_response.g.dart';

@JsonSerializable()
class DoctorSpecialtiesResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<SpecialtyItemResponse>? data;

  DoctorSpecialtiesResponse({this.success, this.data});

  factory DoctorSpecialtiesResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorSpecialtiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSpecialtiesResponseToJson(this);
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
