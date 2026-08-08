import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:tabib_app/features/wallet/data/models/request/create_withdrawal_request.dart';
import 'package:tabib_app/features/wallet/data/models/response/doctor_wallet_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_transactions_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_withdrawal_details_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_withdrawals_response.dart';

@LazySingleton(as: WalletDataSource)
class WalletDataSourceImpl implements WalletDataSource {
  final ApiClient apiClient;

  WalletDataSourceImpl(this.apiClient);

  @override
  Future<Result<WalletResponse>> getPatientWallet() {
    return executeApi(() => apiClient.getPatientWallet());
  }

  @override
  Future<Result<DoctorWalletResponse>> getDoctorWallet() {
    return executeApi(() => apiClient.getDoctorWallet());
  }

  @override
  Future<Result<WalletTransactionsResponse>> getDoctorTransactions({
    required int page,
    required int limit,
  }) {
    return executeApi(
      () => apiClient.getDoctorWalletTransactions(page: page, limit: limit),
    );
  }

  @override
  Future<Result<WalletWithdrawalsResponse>> getDoctorWithdrawals({
    required int page,
    required int limit,
  }) {
    return executeApi(
      () => apiClient.getDoctorWalletWithdrawals(page: page, limit: limit),
    );
  }

  @override
  Future<Result<WalletWithdrawalDetailsResponse>> getDoctorWithdrawalById(
    String id,
  ) {
    return executeApi(() => apiClient.getDoctorWalletWithdrawalById(id));
  }

  @override
  Future<Result<CreateWithdrawalResponse>> createDoctorWithdrawal({
    required CreateWithdrawalRequest request,
    required String idempotencyKey,
  }) {
    return executeApi(
      () => apiClient.createDoctorWalletWithdrawal(idempotencyKey, request),
    );
  }

  @override
  Future<Result<CreateWithdrawalResponse>> cancelDoctorWithdrawal(String id) {
    return executeApi(() => apiClient.cancelDoctorWalletWithdrawal(id));
  }
}
