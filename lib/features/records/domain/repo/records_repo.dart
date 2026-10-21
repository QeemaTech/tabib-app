import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/records/domain/entities/patient_prescription_details_entity.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_page_entity.dart';
import 'package:tabib_app/features/records/domain/entities/patient_report_details_entity.dart';

abstract interface class RecordsRepo {
  Future<Result<PatientRecordPageEntity>> getReports({
    required int page,
    required int limit,
  });

  Future<Result<PatientRecordPageEntity>> getPrescriptions({
    required int page,
    required int limit,
  });

  Future<Result<PatientReportDetailsEntity>> getReportDetails(String id);

  Future<Result<PatientPrescriptionDetailsEntity>> getPrescriptionDetails(
    String id,
  );

  Future<Result<PatientReportDetailsEntity>> getAppointmentReport(String id);

  Future<Result<PatientPrescriptionDetailsEntity>> getAppointmentPrescription(
    String id,
  );
}
