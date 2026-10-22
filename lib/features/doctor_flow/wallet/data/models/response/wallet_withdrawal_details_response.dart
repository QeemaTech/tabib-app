import 'package:json_annotation/json_annotation.dart';

part 'wallet_withdrawal_details_response.g.dart';

@JsonSerializable()
class WalletWithdrawalDetailsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final WalletWithdrawalDetailsDataResponse? data;

  WalletWithdrawalDetailsResponse({
    this.success,
    this.data,
  });

  factory WalletWithdrawalDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletWithdrawalDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletWithdrawalDetailsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WalletWithdrawalDetailsDataResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'amount')
  final num? amount;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'paymentMethodType')
  final String? paymentMethodType;
  @JsonKey(name: 'paymentMethodDetails')
  final Map<String, dynamic>? paymentMethodDetails;
  @JsonKey(name: 'rejectionReason')
  final String? rejectionReason;
  @JsonKey(name: 'transferReference')
  final String? transferReference;
  @JsonKey(name: 'reviewedAt')
  final String? reviewedAt;
  @JsonKey(name: 'completedAt')
  final String? completedAt;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: 'transactions')
  final List<WithdrawalRelatedTransactionResponse>? transactions;

  WalletWithdrawalDetailsDataResponse({
    this.id,
    this.amount,
    this.currency,
    this.status,
    this.paymentMethodType,
    this.paymentMethodDetails,
    this.rejectionReason,
    this.transferReference,
    this.reviewedAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
    this.transactions,
  });

  factory WalletWithdrawalDetailsDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WalletWithdrawalDetailsDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WalletWithdrawalDetailsDataResponseToJson(this);
}

@JsonSerializable()
class WithdrawalRelatedTransactionResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'amount')
  final num? amount;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  WithdrawalRelatedTransactionResponse({
    this.id,
    this.type,
    this.amount,
    this.createdAt,
  });

  factory WithdrawalRelatedTransactionResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WithdrawalRelatedTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WithdrawalRelatedTransactionResponseToJson(this);
}
