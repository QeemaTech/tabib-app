import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';

abstract interface class AppointmentsRepo {
  Future<Result<List<PatientAppointmentEntity>>> getAppointments();

  Future<Result<PatientAppointmentEntity>> cancelAppointment({
    required String id,
    required String cancelReason,
  });
}
