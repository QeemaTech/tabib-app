import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/home/domain/entities/appointment_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_availability_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_details_entity.dart';

abstract interface class DoctorDetailsRepo {
  Future<Result<DoctorDetailsEntity>> getDoctorDetails(String id);

  Future<Result<DoctorAvailabilityEntity>> getDoctorAvailability({
    required String id,
    required String date,
  });

  Future<Result<AppointmentEntity>> bookAppointment({
    required String doctorId,
    required String date,
    required String startTime,
    required String consultationType,
  });
}
