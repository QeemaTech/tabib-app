import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_response.dart';

abstract interface class WalletDataSource {
  Future<Result<WalletResponse>> getPatientWallet();
  Future<Result<WalletResponse>> getDoctorWallet();
}
