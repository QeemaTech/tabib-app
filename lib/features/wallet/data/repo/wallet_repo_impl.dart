import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:tabib_app/features/wallet/data/mapper/wallet_mapper.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_response.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_entity.dart';
import 'package:tabib_app/features/wallet/domain/repo/wallet_repo.dart';

@LazySingleton(as: WalletRepo)
class WalletRepoImpl implements WalletRepo {
  final WalletDataSource dataSource;

  WalletRepoImpl(this.dataSource);

  @override
  Future<Result<WalletEntity>> getPatientWallet() async {
    final response = await dataSource.getPatientWallet();
    return _mapResponse(response);
  }

  @override
  Future<Result<WalletEntity>> getDoctorWallet() async {
    final response = await dataSource.getDoctorWallet();
    return _mapResponse(response);
  }

  Result<WalletEntity> _mapResponse(Result<WalletResponse> response) {
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
