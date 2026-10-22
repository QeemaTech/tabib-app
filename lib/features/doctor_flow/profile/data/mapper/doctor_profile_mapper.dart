import 'package:tabib_app/features/doctor_flow/profile/data/models/response/doctor_profile_response.dart';
import 'package:tabib_app/features/doctor_flow/profile/domain/entities/doctor_profile_entity.dart';

extension DoctorProfileResponseMapper on DoctorProfileResponse {
  DoctorProfileEntity toEntity() {
    final data = this.data;
    return DoctorProfileEntity(
      id: data?.id ?? '',
      fullNameAr: data?.fullNameAr ?? '',
      fullNameEn: data?.fullNameEn ?? '',
      avatarUrl: data?.avatarUrl ?? '',
      bioAr: data?.bioAr ?? '',
      bioEn: data?.bioEn ?? '',
      experienceYears: data?.experienceYears ?? 0,
      professionalTitle: data?.professionalTitle ?? '',
      professionalTitleAr: data?.professionalTitleAr ?? '',
      consultationFee: data?.consultationFee?.toDouble() ?? 0,
      feeChat: data?.feeChat?.toDouble(),
      feeVoice: data?.feeVoice?.toDouble(),
      feeVideo: data?.feeVideo?.toDouble(),
      durationChat: data?.durationChat,
      durationVoice: data?.durationVoice,
      durationVideo: data?.durationVideo,
      durationCallMinutes: data?.durationCallMinutes,
      verificationStatus: data?.verificationStatus ?? '',
      rejectionReason: data?.rejectionReason,
      isOnline: data?.isOnline ?? false,
      ratingAvg: data?.ratingAvg?.toDouble() ?? 0,
      ratingCount: data?.ratingCount ?? 0,
      phone: data?.phone ?? '',
      email: data?.email ?? '',
      mainSpecialty: data?.mainSpecialty?.toEntity(),
      subSpecialties:
          data?.subSpecialties?.map((e) => e.toEntity()).toList() ?? const [],
      specialties:
          data?.specialties?.map((e) => e.toEntity()).toList() ?? const [],
      clinic: data?.clinic?.toEntity(),
      documents:
          data?.documents?.map((e) => e.toEntity()).toList() ?? const [],
      minConsultationFee: data?.minConsultationFee?.toDouble(),
    );
  }
}

extension DoctorProfileSpecialtyRefResponseMapper
    on DoctorProfileSpecialtyRefResponse {
  DoctorProfileSpecialtyRefEntity toEntity() {
    return DoctorProfileSpecialtyRefEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
    );
  }
}

extension DoctorProfileSpecialtyItemResponseMapper
    on DoctorProfileSpecialtyItemResponse {
  DoctorProfileSpecialtyItemEntity toEntity() {
    return DoctorProfileSpecialtyItemEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
      iconUrl: iconUrl,
      isPrimary: isPrimary ?? false,
    );
  }
}

extension DoctorProfileClinicResponseMapper on DoctorProfileClinicResponse {
  DoctorProfileClinicEntity toEntity() {
    return DoctorProfileClinicEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      addressAr: addressAr ?? '',
      lat: lat?.toDouble(),
      lng: lng?.toDouble(),
    );
  }
}

extension DoctorProfileDocumentResponseMapper on DoctorProfileDocumentResponse {
  DoctorProfileDocumentEntity toEntity() {
    return DoctorProfileDocumentEntity(
      id: id ?? '',
      type: type ?? '',
      fileUrl: fileUrl ?? '',
      status: status ?? '',
      createdAt: createdAt ?? '',
    );
  }
}
