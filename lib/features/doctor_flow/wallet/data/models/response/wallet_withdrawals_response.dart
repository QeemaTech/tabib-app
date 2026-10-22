import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_transactions_response.dart';

part 'wallet_withdrawals_response.g.dart';

@JsonSerializable()
class WalletWithdrawalsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<WalletWithdrawalItemResponse>? data;
  @JsonKey(name: 'meta')
  final WalletPageMetaResponse? meta;

  WalletWithdrawalsResponse({
    this.success,
    this.data,
    this.meta,
  });

  factory WalletWithdrawalsResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletWithdrawalsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletWithdrawalsResponseToJson(this);
}

@JsonSerializable()
class WalletWithdrawalItemResponse {
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

  WalletWithdrawalItemResponse({
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
  });

  factory WalletWithdrawalItemResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletWithdrawalItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletWithdrawalItemResponseToJson(this);
}

@JsonSerializable()
class CreateWithdrawalResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final WalletWithdrawalItemResponse? data;

  CreateWithdrawalResponse({
    this.success,
    this.data,
  });

  factory CreateWithdrawalResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateWithdrawalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWithdrawalResponseToJson(this);
}
