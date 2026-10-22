import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/wallet/data/data_source/wallet_data_source.dart';
import 'package:tabib_app/features/patient_flow/wallet/data/models/response/wallet_response.dart';

@LazySingleton(as: PatientWalletDataSource)
class PatientWalletDataSourceImpl implements PatientWalletDataSource {
  final ApiClient apiClient;

  PatientWalletDataSourceImpl(this.apiClient);

  @override
  Future<Result<WalletResponse>> getPatientWallet() {
    return executeApi(() => apiClient.getPatientWallet());
  }
}
