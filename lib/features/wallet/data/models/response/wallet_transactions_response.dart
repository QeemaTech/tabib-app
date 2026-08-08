import 'package:json_annotation/json_annotation.dart';

part 'wallet_transactions_response.g.dart';

@JsonSerializable()
class WalletTransactionsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final List<WalletTransactionItemResponse>? data;
  @JsonKey(name: 'meta')
  final WalletPageMetaResponse? meta;

  WalletTransactionsResponse({
    this.success,
    this.data,
    this.meta,
  });

  factory WalletTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransactionsResponseToJson(this);
}

@JsonSerializable()
class WalletTransactionItemResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'amount')
  final num? amount;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'paymentId')
  final String? paymentId;
  @JsonKey(name: 'withdrawalId')
  final String? withdrawalId;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'metadata')
  final Map<String, dynamic>? metadata;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  WalletTransactionItemResponse({
    this.id,
    this.type,
    this.amount,
    this.currency,
    this.paymentId,
    this.withdrawalId,
    this.note,
    this.metadata,
    this.createdAt,
  });

  factory WalletTransactionItemResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransactionItemResponseToJson(this);
}

@JsonSerializable()
class WalletPageMetaResponse {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'totalPages')
  final int? totalPages;

  WalletPageMetaResponse({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory WalletPageMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletPageMetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletPageMetaResponseToJson(this);
}
