import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/data/data_source/appointments_data_source.dart';
import 'package:tabib_app/features/appointments/data/models/request/cancel_appointment_request.dart';
import 'package:tabib_app/features/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointments_response.dart';

@LazySingleton(as: AppointmentsDataSource)
class AppointmentsDataSourceImpl implements AppointmentsDataSource {
  final ApiClient apiClient;

  AppointmentsDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientAppointmentsResponse>> getAppointments() {
    return executeApi(() => apiClient.getPatientAppointments());
  }

  @override
  Future<Result<CancelAppointmentResponse>> cancelAppointment({
    required String id,
    required CancelAppointmentRequest request,
  }) {
    return executeApi(
      () => apiClient.cancelAppointment(id, request),
    );
  }
}
