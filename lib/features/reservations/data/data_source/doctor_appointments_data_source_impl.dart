import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/reservations/data/data_source/doctor_appointments_data_source.dart';
import 'package:tabib_app/features/reservations/data/models/response/doctor_appointments_response.dart';

@LazySingleton(as: DoctorAppointmentsDataSource)
class DoctorAppointmentsDataSourceImpl implements DoctorAppointmentsDataSource {
  final ApiClient apiClient;

  DoctorAppointmentsDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorAppointmentsResponse>> getAppointments({
    String? status,
  }) {
    return executeApi(
      () => apiClient.getDoctorAppointments(status: status),
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
}
