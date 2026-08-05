import 'package:json_annotation/json_annotation.dart';

part 'doctor_profile_response.g.dart';

@JsonSerializable()
class DoctorProfileResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorProfileDataResponse? data;

  DoctorProfileResponse({this.success, this.data});

  factory DoctorProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorProfileResponseToJson(this);
}

@JsonSerializable()
class DoctorProfileDataResponse {
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
  @JsonKey(name: 'professionalTitle')
  final String? professionalTitle;
  @JsonKey(name: 'professionalTitleAr')
  final String? professionalTitleAr;
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
  @JsonKey(name: 'durationCallMinutes')
  final int? durationCallMinutes;
  @JsonKey(name: 'verificationStatus')
  final String? verificationStatus;
  @JsonKey(name: 'rejectionReason')
  final String? rejectionReason;
  @JsonKey(name: 'isOnline')
  final bool? isOnline;
  @JsonKey(name: 'ratingAvg')
  final num? ratingAvg;
  @JsonKey(name: 'ratingCount')
  final int? ratingCount;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'mainSpecialty')
  final DoctorProfileSpecialtyRefResponse? mainSpecialty;
  @JsonKey(name: 'subSpecialties')
  final List<DoctorProfileSpecialtyRefResponse>? subSpecialties;
  @JsonKey(name: 'specialties')
  final List<DoctorProfileSpecialtyItemResponse>? specialties;
  @JsonKey(name: 'clinic')
  final DoctorProfileClinicResponse? clinic;
  @JsonKey(name: 'documents')
  final List<DoctorProfileDocumentResponse>? documents;
  @JsonKey(name: 'minConsultationFee')
  final num? minConsultationFee;

  DoctorProfileDataResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.bioAr,
    this.bioEn,
    this.experienceYears,
    this.professionalTitle,
    this.professionalTitleAr,
    this.consultationFee,
    this.feeChat,
    this.feeVoice,
    this.feeVideo,
    this.durationChat,
    this.durationVoice,
    this.durationVideo,
    this.durationCallMinutes,
    this.verificationStatus,
    this.rejectionReason,
    this.isOnline,
    this.ratingAvg,
    this.ratingCount,
    this.phone,
    this.email,
    this.mainSpecialty,
    this.subSpecialties,
    this.specialties,
    this.clinic,
    this.documents,
    this.minConsultationFee,
  });

  factory DoctorProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorProfileDataResponseToJson(this);
}

@JsonSerializable()
class DoctorProfileSpecialtyRefResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;

  DoctorProfileSpecialtyRefResponse({this.id, this.nameAr, this.nameEn});

  factory DoctorProfileSpecialtyRefResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorProfileSpecialtyRefResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorProfileSpecialtyRefResponseToJson(this);
}

@JsonSerializable()
class DoctorProfileSpecialtyItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;
  @JsonKey(name: 'iconUrl')
  final String? iconUrl;
  @JsonKey(name: 'isPrimary')
  final bool? isPrimary;

  DoctorProfileSpecialtyItemResponse({
    this.id,
    this.nameAr,
    this.nameEn,
    this.iconUrl,
    this.isPrimary,
  });

  factory DoctorProfileSpecialtyItemResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DoctorProfileSpecialtyItemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorProfileSpecialtyItemResponseToJson(this);
}

@JsonSerializable()
class DoctorProfileClinicResponse {
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

  DoctorProfileClinicResponse({
    this.id,
    this.nameAr,
    this.addressAr,
    this.lat,
    this.lng,
  });

  factory DoctorProfileClinicResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileClinicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorProfileClinicResponseToJson(this);
}

@JsonSerializable()
class DoctorProfileDocumentResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'fileUrl')
  final String? fileUrl;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  DoctorProfileDocumentResponse({
    this.id,
    this.type,
    this.fileUrl,
    this.status,
    this.createdAt,
  });

  factory DoctorProfileDocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfileDocumentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorProfileDocumentResponseToJson(this);
}
