import 'package:json_annotation/json_annotation.dart';

part 'create_payment_request.g.dart';

@JsonSerializable()
class CreatePaymentRequest {
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'couponCode', includeIfNull: false)
  final String? couponCode;
  @JsonKey(name: 'useWallet')
  final bool? useWallet;
  @JsonKey(name: 'payerAccountNo')
  final String? payerAccountNo;

  CreatePaymentRequest({
    this.appointmentId,
    this.couponCode,
    this.useWallet,
    this.payerAccountNo,
  });

  factory CreatePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentRequestToJson(this);
}
