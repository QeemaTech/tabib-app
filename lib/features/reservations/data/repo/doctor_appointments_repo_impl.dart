import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/reservations/data/data_source/doctor_appointments_data_source.dart';
import 'package:tabib_app/features/reservations/data/mapper/doctor_appointments_mapper.dart';
import 'package:tabib_app/features/reservations/data/mapper/doctor_report_mapper.dart';
import 'package:tabib_app/features/reservations/data/models/request/create_doctor_report_request.dart';
import 'package:tabib_app/features/reservations/data/models/request/reject_appointment_request.dart';
import 'package:tabib_app/features/reservations/data/models/response/create_doctor_report_response.dart';
import 'package:tabib_app/features/reservations/data/models/response/doctor_appointments_response.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_report_entity.dart';
import 'package:tabib_app/features/reservations/domain/repo/doctor_appointments_repo.dart';

@LazySingleton(as: DoctorAppointmentsRepo)
class DoctorAppointmentsRepoImpl implements DoctorAppointmentsRepo {
  final DoctorAppointmentsDataSource dataSource;

  DoctorAppointmentsRepoImpl(this.dataSource);

  @override
  Future<Result<List<DoctorAppointmentEntity>>> getAppointments({
    String? status,
    String? date,
  }) async {
    final response = await dataSource.getAppointments(
      status: status,
      date: date,
    );
    switch (response) {
      case Success<DoctorAppointmentsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorAppointmentsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorAppointmentEntity>> getAppointmentDetails(
    String id,
  ) async {
    final response = await dataSource.getAppointmentDetails(id);
    switch (response) {
      case Success<DoctorAppointmentDetailsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorAppointmentDetailsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorReportEntity>> createReport(
    String appointmentId,
    CreateDoctorReportRequest request,
  ) async {
    final response = await dataSource.createReport(appointmentId, request);
    switch (response) {
      case Success<CreateDoctorReportResponse>():
        return Success(response.data.toEntity());
      case Failure<CreateDoctorReportResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorAppointmentEntity>> acceptAppointment(String id) async {
    final response = await dataSource.acceptAppointment(id);
    switch (response) {
      case Success<DoctorAppointmentDetailsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorAppointmentDetailsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorAppointmentEntity>> rejectAppointment({
    required String id,
    required String reason,
  }) async {
    final response = await dataSource.rejectAppointment(
      id,
      RejectAppointmentRequest(reason: reason),
    );
    switch (response) {
      case Success<DoctorAppointmentDetailsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorAppointmentDetailsResponse>():
        return Failure(response.errorMessage);
    }
  }
}
