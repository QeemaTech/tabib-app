import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/records/data/data_source/records_data_source.dart';
import 'package:tabib_app/features/patient_flow/records/data/mapper/patient_records_mapper.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_prescriptions_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_record_detail_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_reports_response.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_prescription_details_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_page_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_report_details_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/repo/records_repo.dart';

@LazySingleton(as: RecordsRepo)
class RecordsRepoImpl implements RecordsRepo {
  final RecordsDataSource dataSource;

  RecordsRepoImpl(this.dataSource);

  @override
  Future<Result<PatientRecordPageEntity>> getReports({
    required int page,
    required int limit,
  }) async {
    final response = await dataSource.getReports(page: page, limit: limit);
    switch (response) {
      case Success<PatientReportsResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientReportsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientRecordPageEntity>> getPrescriptions({
    required int page,
    required int limit,
  }) async {
    final response = await dataSource.getPrescriptions(
      page: page,
      limit: limit,
    );
    switch (response) {
      case Success<PatientPrescriptionsResponse>():
        return Success(response.data.toEntity());
      case Failure<PatientPrescriptionsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientReportDetailsEntity>> getReportDetails(String id) async {
    final response = await dataSource.getReportDetails(id);
    switch (response) {
      case Success<PatientRecordDetailResponse>():
        return Success(response.data.toReportEntity());
      case Failure<PatientRecordDetailResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientPrescriptionDetailsEntity>> getPrescriptionDetails(
    String id,
  ) async {
    final response = await dataSource.getPrescriptionDetails(id);
    switch (response) {
      case Success<PatientRecordDetailResponse>():
        return Success(response.data.toPrescriptionEntity());
      case Failure<PatientRecordDetailResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientReportDetailsEntity>> getAppointmentReport(
    String id,
  ) async {
    final response = await dataSource.getAppointmentReport(id);
    switch (response) {
      case Success<PatientRecordDetailResponse>():
        return Success(response.data.toReportEntity());
      case Failure<PatientRecordDetailResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientPrescriptionDetailsEntity>> getAppointmentPrescription(
    String id,
  ) async {
    final response = await dataSource.getAppointmentPrescription(id);
    switch (response) {
      case Success<PatientRecordDetailResponse>():
        return Success(response.data.toPrescriptionEntity());
      case Failure<PatientRecordDetailResponse>():
        return Failure(response.errorMessage);
    }
  }
}
