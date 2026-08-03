import 'package:json_annotation/json_annotation.dart';

part 'doctor_details_response.g.dart';

@JsonSerializable()
class DoctorDetailsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorDetailsData? data;

  DoctorDetailsResponse({
    this.success,
    this.data,
  });

  factory DoctorDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDetailsResponseToJson(this);
}

@JsonSerializable()
class DoctorDetailsData {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'bioAr')
  final String? bioAr;
  @JsonKey(name: 'bioEn')
  final String? bioEn;
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
  final List<DoctorSpecialtyResponse>? specialties;
  @JsonKey(name: 'clinic')
  final DoctorClinicResponse? clinic;
  @JsonKey(name: 'certificates')
  final List<DoctorCertificateResponse>? certificates;
  @JsonKey(name: 'reviews')
  final List<DoctorReviewResponse>? reviews;

  DoctorDetailsData({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.bioAr,
    this.bioEn,
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
    this.clinic,
    this.certificates,
    this.reviews,
  });

  factory DoctorDetailsData.fromJson(Map<String, dynamic> json) =>
      _$DoctorDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDetailsDataToJson(this);
}

@JsonSerializable()
class DoctorSpecialtyResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;

  DoctorSpecialtyResponse({
    this.id,
    this.nameAr,
    this.nameEn,
  });

  factory DoctorSpecialtyResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorSpecialtyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSpecialtyResponseToJson(this);
}

@JsonSerializable()
class DoctorClinicResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'addressAr')
  final String? addressAr;
  @JsonKey(name: 'lat')
  final num? lat;
  @JsonKey(name: 'lng')
  final num? lng;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'country')
  final String? country;

  DoctorClinicResponse({
    this.id,
    this.nameAr,
    this.addressAr,
    this.lat,
    this.lng,
    this.phone,
    this.city,
    this.country,
  });

  factory DoctorClinicResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorClinicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorClinicResponseToJson(this);
}

@JsonSerializable()
class DoctorCertificateResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'titleAr')
  final String? titleAr;
  @JsonKey(name: 'titleEn')
  final String? titleEn;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  DoctorCertificateResponse({
    this.id,
    this.titleAr,
    this.titleEn,
    this.imageUrl,
  });

  factory DoctorCertificateResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorCertificateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorCertificateResponseToJson(this);
}

@JsonSerializable()
class DoctorReviewResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'rating')
  final num? rating;
  @JsonKey(name: 'commentAr')
  final String? commentAr;
  @JsonKey(name: 'commentEn')
  final String? commentEn;
  @JsonKey(name: 'patientName')
  final String? patientName;

  DoctorReviewResponse({
    this.id,
    this.rating,
    this.commentAr,
    this.commentEn,
    this.patientName,
  });

  factory DoctorReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorReviewResponseToJson(this);
}
