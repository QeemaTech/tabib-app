import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/data_source/doctor_appointments_data_source.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/request/create_doctor_report_request.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/request/reject_appointment_request.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/response/create_doctor_report_response.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/response/doctor_appointments_response.dart';

@LazySingleton(as: DoctorAppointmentsDataSource)
class DoctorAppointmentsDataSourceImpl implements DoctorAppointmentsDataSource {
  final ApiClient apiClient;

  DoctorAppointmentsDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorAppointmentsResponse>> getAppointments({
    String? status,
    String? date,
  }) {
    return executeApi(
      () => apiClient.getDoctorAppointments(status: status, date: date),
    );
  }

  @override
  Future<Result<DoctorAppointmentDetailsResponse>> getAppointmentDetails(
    String id,
  ) {
    return executeApi(
      () => apiClient.getDoctorAppointmentDetails(id),
    );
  }

  @override
  Future<Result<CreateDoctorReportResponse>> createReport(
    String appointmentId,
    CreateDoctorReportRequest request,
  ) {
    return executeApi(
      () => apiClient.createDoctorAppointmentReport(appointmentId, request),
    );
  }

  @override
  Future<Result<DoctorAppointmentDetailsResponse>> acceptAppointment(
    String id,
  ) {
    return executeApi(() => apiClient.acceptDoctorAppointment(id));
  }

  @override
  Future<Result<DoctorAppointmentDetailsResponse>> rejectAppointment(
    String id,
    RejectAppointmentRequest request,
  ) {
    return executeApi(
      () => apiClient.rejectDoctorAppointment(id, request),
    );
  }
}
