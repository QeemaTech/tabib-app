import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/data/models/request/cancel_appointment_request.dart';
import 'package:tabib_app/features/appointments/data/models/request/create_payment_request.dart';
import 'package:tabib_app/features/appointments/data/models/request/validate_coupon_request.dart';
import 'package:tabib_app/features/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/create_payment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointments_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/validate_coupon_response.dart';

abstract interface class AppointmentsDataSource {
  Future<Result<PatientAppointmentsResponse>> getAppointments();

  Future<Result<CancelAppointmentResponse>> cancelAppointment({
    required String id,
    required CancelAppointmentRequest request,
  });

  Future<Result<ValidateCouponResponse>> validateCoupon(
    ValidateCouponRequest request,
  );

  Future<Result<CreatePaymentResponse>> createPayment(
    CreatePaymentRequest request,
  );
}
