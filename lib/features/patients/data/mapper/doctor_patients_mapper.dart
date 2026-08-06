import 'package:tabib_app/features/patients/data/models/response/doctor_patients_response.dart';
import 'package:tabib_app/features/patients/domain/entities/doctor_patient_entity.dart';
import 'package:tabib_app/features/patients/domain/entities/doctor_patient_last_visit_entity.dart';

extension DoctorPatientsResponseMapper on DoctorPatientsResponse {
  List<DoctorPatientEntity> toEntity() {
    return data?.map((item) => item.toEntity()).toList() ?? const [];
  }
}

extension DoctorPatientItemResponseMapper on DoctorPatientItemResponse {
  DoctorPatientEntity toEntity() {
    return DoctorPatientEntity(
      id: id ?? '',
      displayId: displayId ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl,
      age: age ?? 0,
      gender: gender ?? '',
      genderLabelAr: genderLabelAr ?? '',
      status: status ?? '',
      statusLabelAr: statusLabelAr ?? '',
      lastVisit: lastVisit?.toEntity(),
      hasReport: hasReport ?? false,
    );
  }
}

extension DoctorPatientLastVisitResponseMapper
    on DoctorPatientLastVisitResponse {
  DoctorPatientLastVisitEntity toEntity() {
    return DoctorPatientLastVisitEntity(
      appointmentId: appointmentId ?? '',
      date: date ?? '',
      startTime: startTime ?? '',
    );
  }
}
