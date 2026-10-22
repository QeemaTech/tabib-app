import 'package:json_annotation/json_annotation.dart';

part 'doctor_wallet_response.g.dart';

@JsonSerializable()
class DoctorWalletResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorWalletDataResponse? data;

  DoctorWalletResponse({
    this.success,
    this.data,
  });

  factory DoctorWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorWalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorWalletResponseToJson(this);
}

@JsonSerializable()
class DoctorWalletDataResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'availableBalance')
  final num? availableBalance;
  @JsonKey(name: 'pendingBalance')
  final num? pendingBalance;
  @JsonKey(name: 'heldBalance')
  final num? heldBalance;
  @JsonKey(name: 'paidOutBalance')
  final num? paidOutBalance;
  @JsonKey(name: 'totalEarned')
  final num? totalEarned;
  @JsonKey(name: 'minimumWithdrawal')
  final num? minimumWithdrawal;
  @JsonKey(name: 'canWithdraw')
  final bool? canWithdraw;

  DoctorWalletDataResponse({
    this.id,
    this.currency,
    this.availableBalance,
    this.pendingBalance,
    this.heldBalance,
    this.paidOutBalance,
    this.totalEarned,
    this.minimumWithdrawal,
    this.canWithdraw,
  });

  factory DoctorWalletDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorWalletDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorWalletDataResponseToJson(this);
}
