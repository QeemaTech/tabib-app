import 'package:json_annotation/json_annotation.dart';

part 'patient_home_response.g.dart';

@JsonSerializable()
class PatientHomeResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientHomeData? data;

  PatientHomeResponse({
    this.success,
    this.data,
  });

  factory PatientHomeResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientHomeResponseToJson(this);
}

@JsonSerializable()
class PatientHomeData {
  @JsonKey(name: 'banners')
  final List<HomeBannerResponse>? banners;
  @JsonKey(name: 'specialties')
  final List<HomeSpecialtyResponse>? specialties;
  @JsonKey(name: 'featuredDoctors')
  final List<FeaturedDoctorResponse>? featuredDoctors;

  PatientHomeData({
    this.banners,
    this.specialties,
    this.featuredDoctors,
  });

  factory PatientHomeData.fromJson(Map<String, dynamic> json) =>
      _$PatientHomeDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientHomeDataToJson(this);
}

@JsonSerializable()
class HomeBannerResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'titleAr')
  final String? titleAr;
  @JsonKey(name: 'titleEn')
  final String? titleEn;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'linkUrl')
  final String? linkUrl;

  HomeBannerResponse({
    this.id,
    this.titleAr,
    this.titleEn,
    this.imageUrl,
    this.linkUrl,
  });

  factory HomeBannerResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerResponseToJson(this);
}

@JsonSerializable()
class HomeSpecialtyResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;
  @JsonKey(name: 'iconUrl')
  final String? iconUrl;

  HomeSpecialtyResponse({
    this.id,
    this.nameAr,
    this.nameEn,
    this.iconUrl,
  });

  factory HomeSpecialtyResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeSpecialtyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSpecialtyResponseToJson(this);
}

@JsonSerializable()
class FeaturedDoctorResponse {
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
  @JsonKey(name: 'consultationFee')
  final num? consultationFee;
  @JsonKey(name: 'feeChat')
  final num? feeChat;
  @JsonKey(name: 'feeVoice')
  final num? feeVoice;
  @JsonKey(name: 'feeVideo')
  final num? feeVideo;
  @JsonKey(name: 'durationChat')
  final int? durationChat;
  @JsonKey(name: 'durationVoice')
  final int? durationVoice;
  @JsonKey(name: 'durationVideo')
  final int? durationVideo;
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

  FeaturedDoctorResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.experienceYears,
    this.consultationFee,
    this.feeChat,
    this.feeVoice,
    this.feeVideo,
    this.durationChat,
    this.durationVoice,
    this.durationVideo,
    this.ratingAvg,
    this.ratingCount,
    this.isOnline,
    this.specialties,
    this.clinicName,
    this.city,
  });

  factory FeaturedDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$FeaturedDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturedDoctorResponseToJson(this);
}
