import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/wallet/data/data_source/wallet_data_source.dart';
import 'package:tabib_app/features/patient_flow/wallet/data/mapper/wallet_mapper.dart';
import 'package:tabib_app/features/patient_flow/wallet/data/models/response/wallet_response.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/entities/wallet_entity.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/repo/wallet_repo.dart';

@LazySingleton(as: PatientWalletRepo)
class PatientWalletRepoImpl implements PatientWalletRepo {
  final PatientWalletDataSource dataSource;

  PatientWalletRepoImpl(this.dataSource);

  @override
  Future<Result<WalletEntity>> getPatientWallet() async {
    final response = await dataSource.getPatientWallet();
    switch (response) {
      case Success<WalletResponse>():
        final data = response.data.data;
        if (data == null) {
          return const Failure('Invalid wallet response');
        }
        return Success(data.toEntity());
      case Failure<WalletResponse>():
        return Failure(response.errorMessage);
    }
  }
}
