import 'package:tabib_app/features/patient_flow/home/data/models/response/search_doctors_response.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/search_doctor_entity.dart';

extension SearchDoctorsResponseMapper on SearchDoctorsResponse {
  SearchDoctorsResultEntity toEntity() {
    return SearchDoctorsResultEntity(
      doctors: data?.map((item) => item.toEntity()).toList() ?? const [],
      page: meta?.page ?? 1,
      limit: meta?.limit ?? 20,
      total: meta?.total ?? 0,
      totalPages: meta?.totalPages ?? 1,
    );
  }
}

extension SearchDoctorItemResponseMapper on SearchDoctorItemResponse {
  SearchDoctorEntity toEntity() {
    return SearchDoctorEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      experienceYears: experienceYears ?? 0,
      bookingPrice: bookingPrice?.toDouble() ?? 0,
      consultationFee: consultationFee?.toDouble() ?? 0,
      currency: currency ?? '',
      durationChatHours: durationChatHours ?? 0,
      durationCallMinutes: durationCallMinutes ?? 0,
      channels: channels ?? const [],
      ratingAvg: ratingAvg?.toDouble() ?? 0,
      ratingCount: ratingCount ?? 0,
      isOnline: isOnline ?? false,
      specialties: specialties ?? const [],
      clinicName: clinicName ?? '',
      city: city ?? '',
    );
  }
}
