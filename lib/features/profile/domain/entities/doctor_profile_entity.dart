import 'package:equatable/equatable.dart';

class DoctorProfileSpecialtyRefEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;

  const DoctorProfileSpecialtyRefEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  String localizedName(String languageCode) {
    if (languageCode.startsWith('ar') && nameAr.isNotEmpty) return nameAr;
    if (nameEn.isNotEmpty) return nameEn;
    return nameAr;
  }

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}

class DoctorProfileSpecialtyItemEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String? iconUrl;
  final bool isPrimary;

  const DoctorProfileSpecialtyItemEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.iconUrl,
    required this.isPrimary,
  });

  String localizedName(String languageCode) {
    if (languageCode.startsWith('ar') && nameAr.isNotEmpty) return nameAr;
    if (nameEn.isNotEmpty) return nameEn;
    return nameAr;
  }

  @override
  List<Object?> get props => [id, nameAr, nameEn, iconUrl, isPrimary];
}

class DoctorProfileClinicEntity extends Equatable {
  final String id;
  final String nameAr;
  final String addressAr;
  final double? lat;
  final double? lng;

  const DoctorProfileClinicEntity({
    required this.id,
    required this.nameAr,
    required this.addressAr,
    this.lat,
    this.lng,
  });

  @override
  List<Object?> get props => [id, nameAr, addressAr, lat, lng];
}

class DoctorProfileDocumentEntity extends Equatable {
  final String id;
  final String type;
  final String fileUrl;
  final String status;
  final String createdAt;

  const DoctorProfileDocumentEntity({
    required this.id,
    required this.type,
    required this.fileUrl,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, fileUrl, status, createdAt];
}

class DoctorProfileEntity extends Equatable {
  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final String bioAr;
  final String bioEn;
  final int experienceYears;
  final String professionalTitle;
  final String professionalTitleAr;
  final double consultationFee;
  final double? feeChat;
  final double? feeVoice;
  final double? feeVideo;
  final int? durationChat;
  final int? durationVoice;
  final int? durationVideo;
  final int? durationCallMinutes;
  final String verificationStatus;
  final String? rejectionReason;
  final bool isOnline;
  final double ratingAvg;
  final int ratingCount;
  final String phone;
  final String email;
  final DoctorProfileSpecialtyRefEntity? mainSpecialty;
  final List<DoctorProfileSpecialtyRefEntity> subSpecialties;
  final List<DoctorProfileSpecialtyItemEntity> specialties;
  final DoctorProfileClinicEntity? clinic;
  final List<DoctorProfileDocumentEntity> documents;
  final double? minConsultationFee;

  const DoctorProfileEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.bioAr,
    required this.bioEn,
    required this.experienceYears,
    required this.professionalTitle,
    required this.professionalTitleAr,
    required this.consultationFee,
    this.feeChat,
    this.feeVoice,
    this.feeVideo,
    this.durationChat,
    this.durationVoice,
    this.durationVideo,
    this.durationCallMinutes,
    required this.verificationStatus,
    this.rejectionReason,
    required this.isOnline,
    required this.ratingAvg,
    required this.ratingCount,
    required this.phone,
    required this.email,
    this.mainSpecialty,
    required this.subSpecialties,
    required this.specialties,
    this.clinic,
    required this.documents,
    this.minConsultationFee,
  });

  bool get hasAvatar => avatarUrl.trim().isNotEmpty;

  bool get isVerified =>
      verificationStatus.toUpperCase() == 'VERIFIED' ||
      verificationStatus.toUpperCase() == 'APPROVED';

  String localizedName(String languageCode) {
    if (languageCode.startsWith('ar') && fullNameAr.isNotEmpty) {
      return fullNameAr;
    }
    if (fullNameEn.isNotEmpty) return fullNameEn;
    return fullNameAr;
  }

  String localizedTitle(String languageCode) {
    if (languageCode.startsWith('ar') && professionalTitleAr.isNotEmpty) {
      return professionalTitleAr;
    }
    if (professionalTitle.isNotEmpty) return professionalTitle;
    return professionalTitleAr;
  }

  String localizedBio(String languageCode) {
    if (languageCode.startsWith('ar') && bioAr.isNotEmpty) return bioAr;
    if (bioEn.isNotEmpty) return bioEn;
    return bioAr;
  }

  @override
  List<Object?> get props => [
        id,
        fullNameAr,
        fullNameEn,
        avatarUrl,
        bioAr,
        bioEn,
        experienceYears,
        professionalTitle,
        professionalTitleAr,
        consultationFee,
        feeChat,
        feeVoice,
        feeVideo,
        durationChat,
        durationVoice,
        durationVideo,
        durationCallMinutes,
        verificationStatus,
        rejectionReason,
        isOnline,
        ratingAvg,
        ratingCount,
        phone,
        email,
        mainSpecialty,
        subSpecialties,
        specialties,
        clinic,
        documents,
        minConsultationFee,
      ];
}
