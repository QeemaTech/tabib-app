import 'package:tabib_app/features/home/data/models/response/patient_home_response.dart';
import 'package:tabib_app/features/home/domain/entities/featured_doctor_entity.dart';
import 'package:tabib_app/features/home/domain/entities/home_banner_entity.dart';
import 'package:tabib_app/features/home/domain/entities/home_specialty_entity.dart';
import 'package:tabib_app/features/home/domain/entities/patient_home_entity.dart';

extension PatientHomeResponseMapper on PatientHomeResponse {
  PatientHomeEntity toEntity() {
    final data = this.data;
    return PatientHomeEntity(
      banners:
          data?.banners?.map((banner) => banner.toEntity()).toList() ??
          const [],
      specialties:
          data?.specialties?.map((specialty) => specialty.toEntity()).toList() ??
          const [],
      featuredDoctors:
          data?.featuredDoctors
              ?.map((doctor) => doctor.toEntity())
              .toList() ??
          const [],
    );
  }
}

extension HomeBannerResponseMapper on HomeBannerResponse {
  HomeBannerEntity toEntity() {
    return HomeBannerEntity(
      id: id ?? '',
      titleAr: titleAr ?? '',
      titleEn: titleEn ?? '',
      imageUrl: imageUrl ?? '',
      linkUrl: linkUrl,
    );
  }
}

extension HomeSpecialtyResponseMapper on HomeSpecialtyResponse {
  HomeSpecialtyEntity toEntity() {
    return HomeSpecialtyEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
      iconUrl: iconUrl,
    );
  }
}

extension FeaturedDoctorResponseMapper on FeaturedDoctorResponse {
  FeaturedDoctorEntity toEntity() {
    return FeaturedDoctorEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      experienceYears: experienceYears ?? 0,
      consultationFee: consultationFee?.toDouble() ?? 0,
      feeChat: feeChat?.toDouble(),
      feeVoice: feeVoice?.toDouble(),
      feeVideo: feeVideo?.toDouble(),
      durationChat: durationChat,
      durationVoice: durationVoice,
      durationVideo: durationVideo,
      ratingAvg: ratingAvg?.toDouble() ?? 0,
      ratingCount: ratingCount ?? 0,
      isOnline: isOnline ?? false,
      specialties: specialties ?? const [],
      clinicName: clinicName ?? '',
      city: city,
    );
  }
}
