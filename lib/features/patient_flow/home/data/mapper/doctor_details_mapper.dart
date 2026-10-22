import 'package:tabib_app/features/patient_flow/home/data/models/response/doctor_details_response.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_certificate_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_clinic_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_details_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_review_entity.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_specialty_entity.dart';

extension DoctorDetailsResponseMapper on DoctorDetailsResponse {
  DoctorDetailsEntity toEntity() {
    final data = this.data;
    return DoctorDetailsEntity(
      id: data?.id ?? '',
      fullNameAr: data?.fullNameAr ?? '',
      fullNameEn: data?.fullNameEn ?? '',
      avatarUrl: data?.avatarUrl ?? '',
      bioAr: data?.bioAr ?? '',
      bioEn: data?.bioEn ?? '',
      experienceYears: data?.experienceYears ?? 0,
      consultationFee: data?.consultationFee?.toDouble() ?? 0,
      feeChat: data?.feeChat?.toDouble(),
      feeVoice: data?.feeVoice?.toDouble(),
      feeVideo: data?.feeVideo?.toDouble(),
      durationChat: data?.durationChat,
      durationVoice: data?.durationVoice,
      durationVideo: data?.durationVideo,
      ratingAvg: data?.ratingAvg?.toDouble() ?? 0,
      ratingCount: data?.ratingCount ?? 0,
      isOnline: data?.isOnline ?? false,
      specialties:
          data?.specialties?.map((item) => item.toEntity()).toList() ??
          const [],
      clinic: data?.clinic?.toEntity(),
      certificates:
          data?.certificates?.map((item) => item.toEntity()).toList() ??
          const [],
      reviews:
          data?.reviews?.map((item) => item.toEntity()).toList() ?? const [],
    );
  }
}

extension DoctorSpecialtyResponseMapper on DoctorSpecialtyResponse {
  DoctorSpecialtyEntity toEntity() {
    return DoctorSpecialtyEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
    );
  }
}

extension DoctorClinicResponseMapper on DoctorClinicResponse {
  DoctorClinicEntity toEntity() {
    return DoctorClinicEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      addressAr: addressAr ?? '',
      lat: lat?.toDouble() ?? 0,
      lng: lng?.toDouble() ?? 0,
      phone: phone ?? '',
      city: city ?? '',
      country: country ?? '',
    );
  }
}

extension DoctorCertificateResponseMapper on DoctorCertificateResponse {
  DoctorCertificateEntity toEntity() {
    return DoctorCertificateEntity(
      id: id ?? '',
      titleAr: titleAr ?? '',
      titleEn: titleEn ?? '',
      imageUrl: imageUrl,
    );
  }
}

extension DoctorReviewResponseMapper on DoctorReviewResponse {
  DoctorReviewEntity toEntity() {
    return DoctorReviewEntity(
      id: id ?? '',
      rating: rating?.toDouble() ?? 0,
      commentAr: commentAr ?? '',
      commentEn: commentEn ?? '',
      patientName: patientName ?? '',
    );
  }
}
