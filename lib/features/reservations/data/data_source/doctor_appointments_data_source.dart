import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/reservations/data/models/response/doctor_appointments_response.dart';

abstract interface class DoctorAppointmentsDataSource {
  Future<Result<DoctorAppointmentsResponse>> getAppointments({
    String? status,
  });

  Future<Result<DoctorAppointmentDetailsResponse>> getAppointmentDetails(
    String id,
  );
}
