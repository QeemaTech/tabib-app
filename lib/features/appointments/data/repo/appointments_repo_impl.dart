import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/data/data_source/appointments_data_source.dart';
import 'package:tabib_app/features/appointments/data/mapper/cancel_appointment_mapper.dart';
import 'package:tabib_app/features/appointments/data/mapper/patient_appointments_mapper.dart';
import 'package:tabib_app/features/appointments/data/models/request/cancel_appointment_request.dart';
import 'package:tabib_app/features/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointments_response.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:tabib_app/features/appointments/domain/repo/appointments_repo.dart';

@LazySingleton(as: AppointmentsRepo)
class AppointmentsRepoImpl implements AppointmentsRepo {
  final AppointmentsDataSource dataSource;

  AppointmentsRepoImpl(this.dataSource);

  @override
  Future<Result<List<PatientAppointmentEntity>>> getAppointments() async {
    final response = await dataSource.getAppointments();
    switch (response) {
      case Success<PatientAppointmentsResponse>():
        return Success(response.data.toEntityList());
      case Failure<PatientAppointmentsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<PatientAppointmentEntity>> cancelAppointment({
    required String id,
    required String cancelReason,
  }) async {
    final response = await dataSource.cancelAppointment(
      id: id,
      request: CancelAppointmentRequest(cancelReason: cancelReason),
    );
    switch (response) {
      case Success<CancelAppointmentResponse>():
        return Success(response.data.toEntity());
      case Failure<CancelAppointmentResponse>():
        return Failure(response.errorMessage);
    }
  }
}
