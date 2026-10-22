import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/wallet/data/models/response/wallet_response.dart';

abstract interface class PatientWalletDataSource {
  Future<Result<WalletResponse>> getPatientWallet();
}
