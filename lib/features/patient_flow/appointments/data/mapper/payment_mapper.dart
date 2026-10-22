import 'package:tabib_app/features/patient_flow/appointments/data/models/response/create_payment_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/validate_coupon_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/coupon_validation_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/payment_entity.dart';

extension ValidateCouponResponseMapper on ValidateCouponResponse {
  CouponValidationEntity toEntity() {
    final data = this.data;
    return CouponValidationEntity(
      code: data?.code ?? '',
      discountType: data?.discountType ?? '',
      discountValue: data?.discountValue?.toDouble() ?? 0,
      discountAmount: data?.discountAmount?.toDouble() ?? 0,
      finalAmount: data?.finalAmount?.toDouble() ?? 0,
      originalAmount: data?.originalAmount?.toDouble() ?? 0,
    );
  }
}

extension CreatePaymentResponseMapper on CreatePaymentResponse {
  PaymentEntity toEntity() {
    final data = this.data;
    return PaymentEntity(
      paymentId: data?.paymentId ?? '',
      status: data?.status ?? '',
      amount: data?.amount?.toDouble() ?? 0,
      currency: data?.currency ?? '',
      discountAmount: data?.discountAmount?.toDouble() ?? 0,
      walletUsed: data?.walletUsed?.toDouble() ?? 0,
      gatewayRef: data?.gatewayRef ?? '',
      paymentUrl: data?.paymentUrl ?? '',
      invoice:
          data?.invoice?.toEntity() ??
          const PaymentInvoiceEntity(id: '', invoiceNumber: '', pdfUrl: ''),
    );
  }
}

extension PaymentInvoiceResponseMapper on PaymentInvoiceResponse {
  PaymentInvoiceEntity toEntity() {
    return PaymentInvoiceEntity(
      id: id ?? '',
      invoiceNumber: invoiceNumber ?? '',
      pdfUrl: pdfUrl ?? '',
    );
  }
}
