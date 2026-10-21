import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/records/data/models/response/patient_prescriptions_response.dart';
import 'package:tabib_app/features/records/data/models/response/patient_record_detail_response.dart';
import 'package:tabib_app/features/records/data/models/response/patient_reports_response.dart';

abstract interface class RecordsDataSource {
  Future<Result<PatientReportsResponse>> getReports({
    required int page,
    required int limit,
  });

  Future<Result<PatientPrescriptionsResponse>> getPrescriptions({
    required int page,
    required int limit,
  });

  Future<Result<PatientRecordDetailResponse>> getReportDetails(String id);

  Future<Result<PatientRecordDetailResponse>> getPrescriptionDetails(String id);

  Future<Result<PatientRecordDetailResponse>> getAppointmentReport(String id);

  Future<Result<PatientRecordDetailResponse>> getAppointmentPrescription(
    String id,
  );
}
