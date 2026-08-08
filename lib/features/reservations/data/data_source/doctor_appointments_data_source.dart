import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/reservations/data/models/request/create_doctor_report_request.dart';
import 'package:tabib_app/features/reservations/data/models/response/create_doctor_report_response.dart';
import 'package:tabib_app/features/reservations/data/models/response/doctor_appointments_response.dart';

abstract interface class DoctorAppointmentsDataSource {
  Future<Result<DoctorAppointmentsResponse>> getAppointments({
    String? status,
    String? date,
  });

  Future<Result<DoctorAppointmentDetailsResponse>> getAppointmentDetails(
    String id,
  );

  Future<Result<CreateDoctorReportResponse>> createReport(
    String appointmentId,
    CreateDoctorReportRequest request,
  );
}
