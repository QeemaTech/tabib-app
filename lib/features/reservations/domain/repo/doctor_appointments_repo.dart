import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/reservations/data/models/request/create_doctor_report_request.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_report_entity.dart';

abstract interface class DoctorAppointmentsRepo {
  Future<Result<List<DoctorAppointmentEntity>>> getAppointments({
    String? status,
  });

  Future<Result<DoctorAppointmentEntity>> getAppointmentDetails(String id);

  Future<Result<DoctorReportEntity>> createReport(
    String appointmentId,
    CreateDoctorReportRequest request,
  );
}
