import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/data/data_source/appointments_data_source.dart';
import 'package:tabib_app/features/appointments/data/models/request/cancel_appointment_request.dart';
import 'package:tabib_app/features/appointments/data/models/request/create_payment_request.dart';
import 'package:tabib_app/features/appointments/data/models/request/validate_coupon_request.dart';
import 'package:tabib_app/features/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/create_payment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointment_details_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_invoice_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_invoices_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointments_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/validate_coupon_response.dart';

@LazySingleton(as: AppointmentsDataSource)
class AppointmentsDataSourceImpl implements AppointmentsDataSource {
  final ApiClient apiClient;

  AppointmentsDataSourceImpl(this.apiClient);

  @override
  Future<Result<PatientAppointmentsResponse>> getAppointments() {
    return executeApi(() => apiClient.getPatientAppointments());
  }

  @override
  Future<Result<PatientAppointmentDetailsResponse>> getAppointmentDetails(
    String id,
  ) {
    return executeApi(() => apiClient.getPatientAppointmentDetails(id));
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

  @override
  Future<Result<ValidateCouponResponse>> validateCoupon(
    ValidateCouponRequest request,
  ) {
    return executeApi(() => apiClient.validateCoupon(request));
  }

  @override
  Future<Result<CreatePaymentResponse>> createPayment(
    CreatePaymentRequest request,
  ) {
    return executeApi(() => apiClient.createPayment(request));
  }

  @override
  Future<Result<PatientInvoiceResponse>> getInvoice(String id) {
    return executeApi(() => apiClient.getPatientInvoice(id));
  }

  @override
  Future<Result<PatientInvoicesResponse>> getInvoices({
    required int page,
    required int limit,
  }) {
    return executeApi(
      () => apiClient.getPatientInvoices(page: page, limit: limit),
    );
  }

  @override
  Future<Result<HttpResponse<Uint8List>>> downloadInvoice(String id) {
    return executeApi(() => apiClient.downloadPatientInvoice(id));
  }
}
