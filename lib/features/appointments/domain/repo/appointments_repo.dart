import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/domain/entities/coupon_validation_entity.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:tabib_app/features/appointments/domain/entities/payment_entity.dart';

abstract interface class AppointmentsRepo {
  Future<Result<List<PatientAppointmentEntity>>> getAppointments();

  Future<Result<PatientAppointmentEntity>> cancelAppointment({
    required String id,
    required String cancelReason,
  });

  Future<Result<CouponValidationEntity>> validateCoupon({
    required String code,
    required String appointmentId,
  });

  Future<Result<PaymentEntity>> createPayment({
    required String appointmentId,
    String? couponCode,
    required bool useWallet,
  });
}
