import 'package:tabib_app/features/patient_flow/wallet/data/models/response/wallet_response.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/entities/wallet_entity.dart';

extension WalletDataResponseMapper on WalletDataResponse {
  WalletEntity toEntity() {
    return WalletEntity(
      balance: balance?.toDouble() ?? 0,
      currency: currency ?? '',
    );
  }
}
