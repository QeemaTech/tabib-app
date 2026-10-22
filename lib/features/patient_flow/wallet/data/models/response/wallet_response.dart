import 'package:json_annotation/json_annotation.dart';

part 'wallet_response.g.dart';

@JsonSerializable()
class WalletResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final WalletDataResponse? data;

  WalletResponse({
    this.success,
    this.data,
  });

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletResponseToJson(this);
}

@JsonSerializable()
class WalletDataResponse {
  @JsonKey(name: 'balance')
  final num? balance;
  @JsonKey(name: 'currency')
  final String? currency;

  WalletDataResponse({
    this.balance,
    this.currency,
  });

  factory WalletDataResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletDataResponseToJson(this);
}
