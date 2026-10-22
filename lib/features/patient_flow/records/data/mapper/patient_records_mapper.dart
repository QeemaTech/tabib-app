import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_prescriptions_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_record_common_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_record_detail_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_reports_response.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_prescription_details_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_actions_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_diagnosis_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_doctor_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_list_item_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_medication_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_page_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_report_details_entity.dart';

extension PatientReportsResponseMapper on PatientReportsResponse {
  PatientRecordPageEntity toEntity() {
    return PatientRecordPageEntity(
      items: data?.map((item) => item.toEntity()).toList() ?? const [],
      page: meta?.page ?? 1,
      limit: meta?.limit ?? 20,
      total: meta?.total ?? 0,
      totalPages: meta?.totalPages ?? 1,
    );
  }
}

extension PatientReportListItemResponseMapper on PatientReportListItemResponse {
  PatientRecordListItemEntity toEntity() {
    return PatientRecordListItemEntity(
      id: id ?? '',
      kind: PatientRecordKind.report,
      referenceNumber: referenceNumber ?? '',
      doctor: doctor?.toEntity() ?? const PatientRecordDoctorEntity.empty(),
      summary: _firstNonEmpty([summaryAr, summaryEn, diagnosisAr]),
      occurredAt: occurredAt ?? '',
    );
  }
}

extension PatientPrescriptionsResponseMapper on PatientPrescriptionsResponse {
  PatientRecordPageEntity toEntity() {
    return PatientRecordPageEntity(
      items: data?.map((item) => item.toEntity()).toList() ?? const [],
      page: meta?.page ?? 1,
      limit: meta?.limit ?? 20,
      total: meta?.total ?? 0,
      totalPages: meta?.totalPages ?? 1,
    );
  }
}

extension PatientPrescriptionListItemResponseMapper
    on PatientPrescriptionListItemResponse {
  PatientRecordListItemEntity toEntity() {
    return PatientRecordListItemEntity(
      id: id ?? '',
      kind: PatientRecordKind.prescription,
      referenceNumber: referenceNumber ?? '',
      doctor: doctor?.toEntity() ?? const PatientRecordDoctorEntity.empty(),
      summary: summaryAr ?? '',
      occurredAt: issuedAt ?? '',
    );
  }
}

extension PatientRecordDetailReportMapper on PatientRecordDetailResponse {
  PatientReportDetailsEntity toReportEntity() {
    final envelope = data;
    final detail = envelope?.detail;
    return PatientReportDetailsEntity(
      screenTitleAr: envelope?.screenTitleAr ?? '',
      screenTitleEn: envelope?.screenTitleEn ?? '',
      referenceNumber: detail?.referenceNumber ?? '',
      referenceLabelAr: detail?.referenceLabelAr ?? '',
      referenceLabelEn: detail?.referenceLabelEn ?? '',
      doctor:
          detail?.doctor?.toEntity() ?? const PatientRecordDoctorEntity.empty(),
      occurredAt: detail?.occurredAt ?? '',
      diagnosisAr: detail?.diagnosisAr ?? '',
      diagnoses:
          detail?.diagnoses?.map((item) => item.toEntity()).toList() ??
          const [],
      visitTypeAr: detail?.visitTypeAr ?? '',
      bloodPressure: detail?.bloodPressure ?? '',
      temperature: detail?.temperature ?? '',
      followUpAr: detail?.followUpAr ?? '',
      medicalNotesAr: detail?.medicalNotesAr ?? '',
      requestedTests:
          detail?.requestedTests?.map((item) => item.toEntity()).toList() ??
          const [],
      prescriptionsCount: detail?.prescriptionsCount ?? 0,
      actions:
          envelope?.actions?.toEntity() ??
          const PatientRecordActionsEntity.empty(),
    );
  }

  PatientPrescriptionDetailsEntity toPrescriptionEntity() {
    final envelope = data;
    final detail = envelope?.detail;
    return PatientPrescriptionDetailsEntity(
      screenTitleAr: envelope?.screenTitleAr ?? '',
      screenTitleEn: envelope?.screenTitleEn ?? '',
      referenceNumber: detail?.referenceNumber ?? '',
      referenceLabelAr: detail?.referenceLabelAr ?? '',
      referenceLabelEn: detail?.referenceLabelEn ?? '',
      doctor:
          detail?.doctor?.toEntity() ?? const PatientRecordDoctorEntity.empty(),
      occurredAt: detail?.occurredAt ?? '',
      summaryAr: detail?.summaryAr ?? '',
      diagnosisAr: detail?.diagnosisAr ?? '',
      medications:
          detail?.medications?.map((item) => item.toEntity()).toList() ??
          const [],
      actions:
          envelope?.actions?.toEntity() ??
          const PatientRecordActionsEntity.empty(),
    );
  }
}

extension PatientRecordDoctorResponseMapper on PatientRecordDoctorResponse {
  PatientRecordDoctorEntity toEntity() {
    return PatientRecordDoctorEntity(
      id: id ?? '',
      fullNameAr: fullNameAr ?? '',
      fullNameEn: fullNameEn ?? '',
      avatarUrl: avatarUrl ?? '',
      specialtyAr: specialtyAr ?? '',
      specialtyEn: specialtyEn ?? '',
    );
  }
}

extension PatientRecordActionsResponseMapper on PatientRecordActionsResponse {
  PatientRecordActionsEntity toEntity() {
    return PatientRecordActionsEntity(
      canDownloadPdf: canDownloadPdf ?? false,
      downloadPdfUrl: downloadPdfUrl ?? '',
      canBookFollowUp: canBookFollowUp ?? false,
      doctorId: doctorId ?? '',
    );
  }
}

extension PatientRecordMedicationResponseMapper
    on PatientRecordMedicationResponse {
  PatientRecordMedicationEntity toEntity() {
    return PatientRecordMedicationEntity(
      id: id ?? '',
      drugNameAr: drugNameAr ?? '',
      drugNameEn: drugNameEn ?? '',
      formAr: formAr ?? '',
      doseAr: doseAr ?? '',
      frequencyAr: frequencyAr ?? '',
      timingAr: timingAr ?? '',
      durationAr: durationAr ?? '',
      noteAr: noteAr ?? '',
    );
  }
}

extension PatientRecordDiagnosisResponseMapper
    on PatientRecordDiagnosisResponse {
  PatientRecordDiagnosisEntity toEntity() {
    return PatientRecordDiagnosisEntity(
      id: id ?? '',
      code: code ?? '',
      descriptionAr: descriptionAr ?? '',
      descriptionEn: descriptionEn ?? '',
    );
  }
}

extension PatientRequestedTestResponseMapper on PatientRequestedTestResponse {
  PatientRequestedTestEntity toEntity() {
    return PatientRequestedTestEntity(id: id ?? '', titleAr: titleAr ?? '');
  }
}

String _firstNonEmpty(List<String?> values) {
  for (final value in values) {
    if (value != null && value.isNotEmpty) return value;
  }
  return '';
}
