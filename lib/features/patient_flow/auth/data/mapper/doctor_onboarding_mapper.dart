import 'package:tabib_app/features/patient_flow/auth/data/models/response/specialties_response.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/specialty_entity.dart';

extension PatientSpecialtiesResponseMapper on PatientSpecialtiesResponse {
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
