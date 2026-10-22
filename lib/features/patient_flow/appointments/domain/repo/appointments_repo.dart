import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/coupon_validation_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/invoice_file_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoice_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoices_page_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/payment_entity.dart';

abstract interface class AppointmentsRepo {
  Future<Result<List<PatientAppointmentEntity>>> getAppointments();

  Future<Result<PatientAppointmentDetailsEntity>> getAppointmentDetails(
    String id,
  );

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
    required String payerAccountNo,
  });

  Future<Result<PatientInvoiceEntity>> getInvoice(String id);

  Future<Result<PatientInvoicesPageEntity>> getInvoices({
    required int page,
    required int limit,
  });

  Future<Result<InvoiceFileEntity>> downloadInvoice(String id);
}
