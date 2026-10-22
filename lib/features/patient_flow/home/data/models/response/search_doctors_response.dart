import 'package:json_annotation/json_annotation.dart';

part 'search_doctors_response.g.dart';

@JsonSerializable()
class SearchDoctorsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<SearchDoctorItemResponse>? data;
  @JsonKey(name: 'meta')
  final SearchDoctorsMetaResponse? meta;

  SearchDoctorsResponse({
    this.success,
    this.data,
    this.meta,
  });

  factory SearchDoctorsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDoctorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDoctorsResponseToJson(this);
}

@JsonSerializable()
class SearchDoctorItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'experienceYears')
  final int? experienceYears;
  @JsonKey(name: 'bookingPrice')
  final num? bookingPrice;
  @JsonKey(name: 'consultationFee')
  final num? consultationFee;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'durationChatHours')
  final int? durationChatHours;
  @JsonKey(name: 'durationCallMinutes')
  final int? durationCallMinutes;
  @JsonKey(name: 'channels')
  @SearchDoctorChannelListConverter()
  final List<String>? channels;
  @JsonKey(name: 'ratingAvg')
  final num? ratingAvg;
  @JsonKey(name: 'ratingCount')
  final int? ratingCount;
  @JsonKey(name: 'isOnline')
  final bool? isOnline;
  @JsonKey(name: 'specialties')
  final List<String>? specialties;
  @JsonKey(name: 'clinicName')
  final String? clinicName;
  @JsonKey(name: 'city')
  final String? city;

  SearchDoctorItemResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.experienceYears,
    this.bookingPrice,
    this.consultationFee,
    this.currency,
    this.durationChatHours,
    this.durationCallMinutes,
    this.channels,
    this.ratingAvg,
    this.ratingCount,
    this.isOnline,
    this.specialties,
    this.clinicName,
    this.city,
  });

  factory SearchDoctorItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDoctorItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDoctorItemResponseToJson(this);
}

@JsonSerializable()
class SearchDoctorsMetaResponse {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'totalPages')
  final int? totalPages;

  SearchDoctorsMetaResponse({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory SearchDoctorsMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDoctorsMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDoctorsMetaResponseToJson(this);
}

class SearchDoctorChannelListConverter
    implements JsonConverter<List<String>?, Object?> {
  const SearchDoctorChannelListConverter();

  @override
  List<String>? fromJson(Object? json) {
    if (json is! List) return null;
    final channels = <String>[];
    for (final item in json) {
      if (item is String && item.isNotEmpty) {
        channels.add(item);
      } else if (item is Map) {
        final type = item['type'];
        if (type is String && type.isNotEmpty) {
          channels.add(type);
        }
      }
    }
    return channels;
  }

  @override
  Object? toJson(List<String>? object) => object;
}
