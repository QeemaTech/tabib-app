import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/entities/wallet_entity.dart';

abstract interface class PatientWalletRepo {
  Future<Result<WalletEntity>> getPatientWallet();
}
