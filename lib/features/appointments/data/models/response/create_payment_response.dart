import 'package:json_annotation/json_annotation.dart';

part 'create_payment_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePaymentResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final CreatePaymentDataResponse? data;

  CreatePaymentResponse({
    this.success,
    this.data,
  });

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreatePaymentDataResponse {
  @JsonKey(name: 'paymentId')
  final String? paymentId;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'amount')
  final num? amount;
  @JsonKey(name: 'discountAmount')
  final num? discountAmount;
  @JsonKey(name: 'walletUsed')
  final num? walletUsed;
  @JsonKey(name: 'gatewayRef')
  final String? gatewayRef;
  @JsonKey(name: 'invoice')
  final PaymentInvoiceResponse? invoice;

  CreatePaymentDataResponse({
    this.paymentId,
    this.status,
    this.amount,
    this.discountAmount,
    this.walletUsed,
    this.gatewayRef,
    this.invoice,
  });

  factory CreatePaymentDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentDataResponseToJson(this);
}

@JsonSerializable()
class PaymentInvoiceResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'invoiceNumber')
  final String? invoiceNumber;
  @JsonKey(name: 'pdfUrl')
  final String? pdfUrl;

  PaymentInvoiceResponse({
    this.id,
    this.invoiceNumber,
    this.pdfUrl,
  });

  factory PaymentInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentInvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInvoiceResponseToJson(this);
}
