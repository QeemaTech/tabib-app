import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_entity.dart';

abstract interface class WalletRepo {
  Future<Result<WalletEntity>> getPatientWallet();
  Future<Result<WalletEntity>> getDoctorWallet();
}
