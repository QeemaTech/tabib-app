import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/records/data/data_source/records_data_source.dart';
import 'package:tabib_app/features/records/data/models/response/patient_prescriptions_response.dart';
import 'package:tabib_app/features/records/data/models/response/patient_record_detail_response.dart';
import 'package:tabib_app/features/records/data/models/response/patient_reports_response.dart';

@LazySingleton(as: RecordsDataSource)
class RecordsDataSourceImpl implements RecordsDataSource {
  final ApiClient apiClient;

  RecordsDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientReportsResponse>> getReports({
    required int page,
    required int limit,
  }) {
    return executeApi(
      () => apiClient.getPatientReports(page: page, limit: limit),
    );
  }

  @override
  Future<Result<PatientPrescriptionsResponse>> getPrescriptions({
    required int page,
    required int limit,
  }) {
    return executeApi(
      () => apiClient.getPatientPrescriptions(page: page, limit: limit),
    );
  }

  @override
  Future<Result<PatientRecordDetailResponse>> getReportDetails(String id) {
    return executeApi(() => apiClient.getPatientReportDetails(id));
  }

  @override
  Future<Result<PatientRecordDetailResponse>> getPrescriptionDetails(
    String id,
  ) {
    return executeApi(() => apiClient.getPatientPrescriptionDetails(id));
  }

  @override
  Future<Result<PatientRecordDetailResponse>> getAppointmentReport(String id) {
    return executeApi(() => apiClient.getPatientAppointmentReport(id));
  }

  @override
  Future<Result<PatientRecordDetailResponse>> getAppointmentPrescription(
    String id,
  ) {
    return executeApi(() => apiClient.getPatientAppointmentPrescription(id));
  }
}
