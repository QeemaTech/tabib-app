import 'package:equatable/equatable.dart';

class PaymentInvoiceEntity extends Equatable {
  final String id;
  final String invoiceNumber;
  final String pdfUrl;

  const PaymentInvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.pdfUrl,
  });

  @override
  List<Object?> get props => [id, invoiceNumber, pdfUrl];
}

class PaymentEntity extends Equatable {
  final String paymentId;
  final String status;
  final double amount;
  final String currency;
  final double discountAmount;
  final double walletUsed;
  final String gatewayRef;
  final String paymentUrl;
  final PaymentInvoiceEntity invoice;

  const PaymentEntity({
    required this.paymentId,
    required this.status,
    required this.amount,
    required this.currency,
    required this.discountAmount,
    required this.walletUsed,
    required this.gatewayRef,
    required this.paymentUrl,
    required this.invoice,
  });

  @override
  List<Object?> get props => [
    paymentId,
    status,
    amount,
    currency,
    discountAmount,
    walletUsed,
    gatewayRef,
    paymentUrl,
    invoice,
  ];
}
