import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/request/create_withdrawal_request.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/doctor_wallet_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_transactions_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_withdrawal_details_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_withdrawals_response.dart';

abstract interface class DoctorWalletDataSource {
  Future<Result<DoctorWalletResponse>> getDoctorWallet();

  Future<Result<WalletTransactionsResponse>> getDoctorTransactions({
    required int page,
    required int limit,
  });

  Future<Result<WalletWithdrawalsResponse>> getDoctorWithdrawals({
    required int page,
    required int limit,
  });

  Future<Result<WalletWithdrawalDetailsResponse>> getDoctorWithdrawalById(
    String id,
  );

  Future<Result<CreateWithdrawalResponse>> createDoctorWithdrawal({
    required CreateWithdrawalRequest request,
    required String idempotencyKey,
  });

  Future<Result<CreateWithdrawalResponse>> cancelDoctorWithdrawal(String id);
}
