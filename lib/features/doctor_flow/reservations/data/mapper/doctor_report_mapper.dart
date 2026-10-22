import 'package:tabib_app/features/doctor_flow/reservations/data/models/response/create_doctor_report_response.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_report_entity.dart';

extension CreateDoctorReportResponseMapper on CreateDoctorReportResponse {
  DoctorReportEntity toEntity() {
    return data?.toEntity() ??
        const DoctorReportEntity(
          appointmentId: '',
          medicalRecordId: '',
          visitTypeAr: '',
          bloodPressure: '',
          temperature: '',
          diagnosis: '',
          medications: [],
          requiredTests: [],
          followUpAr: '',
          medicalNotesAr: '',
          createdAt: '',
        );
  }
}

extension CreateDoctorReportDataResponseMapper
    on CreateDoctorReportDataResponse {
  DoctorReportEntity toEntity() {
    return DoctorReportEntity(
      appointmentId: appointmentId ?? '',
      medicalRecordId: medicalRecordId ?? '',
      visitTypeAr: visitTypeAr ?? '',
      bloodPressure: bloodPressure ?? '',
      temperature: temperature ?? '',
      diagnosis: diagnosis ?? '',
      medications:
          medications?.map((item) => item.toEntity()).toList() ?? const [],
      requiredTests:
          requiredTests?.map((item) => item.toEntity()).toList() ?? const [],
      followUpAr: followUpAr ?? '',
      medicalNotesAr: medicalNotesAr ?? '',
      createdAt: createdAt ?? '',
    );
  }
}

extension CreateDoctorReportMedicationResponseMapper
    on CreateDoctorReportMedicationResponse {
  DoctorReportMedicationEntity toEntity() {
    return DoctorReportMedicationEntity(
      id: id ?? '',
      drugNameAr: drugNameAr ?? '',
      drugNameEn: drugNameEn,
      dosage: dosage ?? '',
      frequency: frequency ?? '',
      duration: duration ?? '',
      instructionsAr: instructionsAr,
    );
  }
}

extension CreateDoctorReportTestResponseMapper
    on CreateDoctorReportTestResponse {
  DoctorReportTestEntity toEntity() {
    return DoctorReportTestEntity(
      id: id ?? '',
      titleAr: titleAr ?? '',
    );
  }
}
