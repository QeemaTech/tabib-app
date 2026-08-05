import 'package:tabib_app/features/auth/data/models/response/doctor_documents_response.dart';
import 'package:tabib_app/features/auth/data/models/response/doctor_professional_response.dart';
import 'package:tabib_app/features/auth/data/models/response/professional_titles_response.dart';
import 'package:tabib_app/features/auth/data/models/response/specialties_response.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_documents_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_professional_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/professional_title_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/specialty_entity.dart';

extension SpecialtiesResponseMapper on SpecialtiesResponse {
  List<SpecialtyEntity> toEntityList() {
    return data?.map((item) => item.toEntity()).toList() ?? const [];
  }
}

extension SpecialtyItemResponseMapper on SpecialtyItemResponse {
  SpecialtyEntity toEntity() {
    return SpecialtyEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
      iconUrl: iconUrl,
      displayOrder: displayOrder ?? 0,
      parentId: parentId,
    );
  }
}

extension ProfessionalTitlesResponseMapper on ProfessionalTitlesResponse {
  List<ProfessionalTitleEntity> toEntityList() {
    return data?.map((item) => item.toEntity()).toList() ?? const [];
  }
}

extension ProfessionalTitleItemResponseMapper on ProfessionalTitleItemResponse {
  ProfessionalTitleEntity toEntity() {
    return ProfessionalTitleEntity(
      value: value ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
    );
  }
}

extension DoctorProfessionalResponseMapper on DoctorProfessionalResponse {
  DoctorProfessionalEntity toEntity() {
    final data = this.data;
    return DoctorProfessionalEntity(
      experienceYears: data?.experienceYears ?? 0,
      professionalTitle: data?.professionalTitle ?? '',
      professionalTitleAr: data?.professionalTitleAr ?? '',
      mainSpecialty: data?.mainSpecialty?.toEntity(),
      subSpecialties:
          data?.subSpecialties?.map((item) => item.toEntity()).toList() ??
          const [],
      consultationFee: data?.consultationFee?.toDouble() ?? 0,
      feeChat: data?.feeChat?.toDouble(),
      feeVoice: data?.feeVoice?.toDouble(),
      feeVideo: data?.feeVideo?.toDouble(),
      durationChat: data?.durationChat,
      durationVoice: data?.durationVoice,
      durationVideo: data?.durationVideo,
    );
  }
}

extension DoctorSpecialtyRefResponseMapper on DoctorSpecialtyRefResponse {
  DoctorSpecialtyRefEntity toEntity() {
    return DoctorSpecialtyRefEntity(
      id: id ?? '',
      nameAr: nameAr ?? '',
      nameEn: nameEn ?? '',
    );
  }
}

extension DoctorDocumentsResponseMapper on DoctorDocumentsResponse {
  DoctorDocumentsEntity toEntity() {
    final data = this.data;
    return DoctorDocumentsEntity(
      verificationStatus: data?.verificationStatus ?? '',
      message: data?.message ?? '',
      documentsSubmitted: data?.documentsSubmitted ?? false,
    );
  }
}
