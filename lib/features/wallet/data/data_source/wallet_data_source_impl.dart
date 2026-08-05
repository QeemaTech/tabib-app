import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_response.dart';

@LazySingleton(as: WalletDataSource)
class WalletDataSourceImpl implements WalletDataSource {
  final ApiClient apiClient;

  WalletDataSourceImpl(this.apiClient);

  @override
  Future<Result<WalletResponse>> getPatientWallet() {
    return executeApi(() => apiClient.getPatientWallet());
  }

  @override
  Future<Result<WalletResponse>> getDoctorWallet() {
    return executeApi(() => apiClient.getDoctorWallet());
  }
}
