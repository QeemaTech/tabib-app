import 'package:json_annotation/json_annotation.dart';

part 'create_withdrawal_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateWithdrawalRequest {
  @JsonKey(name: 'amount')
  final num amount;
  @JsonKey(name: 'paymentMethodType')
  final String paymentMethodType;
  @JsonKey(name: 'paymentMethodDetails')
  final PaymentMethodDetailsRequest paymentMethodDetails;
  @JsonKey(name: 'idempotencyKey')
  final String idempotencyKey;

  CreateWithdrawalRequest({
    required this.amount,
    required this.paymentMethodType,
    required this.paymentMethodDetails,
    required this.idempotencyKey,
  });

  factory CreateWithdrawalRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWithdrawalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWithdrawalRequestToJson(this);
}

@JsonSerializable()
class PaymentMethodDetailsRequest {
  @JsonKey(name: 'iban')
  final String iban;

  PaymentMethodDetailsRequest({required this.iban});

  factory PaymentMethodDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDetailsRequestToJson(this);
}
