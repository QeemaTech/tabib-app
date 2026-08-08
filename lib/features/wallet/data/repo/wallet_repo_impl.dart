import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:tabib_app/features/wallet/data/mapper/doctor_wallet_mapper.dart';
import 'package:tabib_app/features/wallet/data/mapper/wallet_mapper.dart';
import 'package:tabib_app/features/wallet/data/models/request/create_withdrawal_request.dart';
import 'package:tabib_app/features/wallet/data/models/response/doctor_wallet_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_transactions_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_withdrawal_details_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_withdrawals_response.dart';
import 'package:tabib_app/features/wallet/domain/entities/doctor_wallet_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_page_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_details_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_entity.dart';
import 'package:tabib_app/features/wallet/domain/repo/wallet_repo.dart';

@LazySingleton(as: WalletRepo)
class WalletRepoImpl implements WalletRepo {
  final WalletDataSource dataSource;

  WalletRepoImpl(this.dataSource);

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

  @override
  Future<Result<DoctorWalletEntity>> getDoctorWallet() async {
    final response = await dataSource.getDoctorWallet();
    switch (response) {
      case Success<DoctorWalletResponse>():
        final data = response.data.data;
        if (data == null) {
          return const Failure('Invalid wallet response');
        }
        return Success(data.toEntity());
      case Failure<DoctorWalletResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<WalletPageEntity<WalletTransactionEntity>>>
      getDoctorTransactions({
    required int page,
    required int limit,
  }) async {
    final response = await dataSource.getDoctorTransactions(
      page: page,
      limit: limit,
    );
    switch (response) {
      case Success<WalletTransactionsResponse>():
        return Success(response.data.toEntity());
      case Failure<WalletTransactionsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<WalletPageEntity<WalletWithdrawalEntity>>>
      getDoctorWithdrawals({
    required int page,
    required int limit,
  }) async {
    final response = await dataSource.getDoctorWithdrawals(
      page: page,
      limit: limit,
    );
    switch (response) {
      case Success<WalletWithdrawalsResponse>():
        return Success(response.data.toEntity());
      case Failure<WalletWithdrawalsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<WalletWithdrawalDetailsEntity>> getDoctorWithdrawalById(
    String id,
  ) async {
    final response = await dataSource.getDoctorWithdrawalById(id);
    switch (response) {
      case Success<WalletWithdrawalDetailsResponse>():
        final data = response.data.data;
        if (data == null) {
          return const Failure('Invalid withdrawal details response');
        }
        return Success(data.toEntity());
      case Failure<WalletWithdrawalDetailsResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<WalletWithdrawalEntity>> createDoctorWithdrawal({
    required double amount,
    required String iban,
    required String idempotencyKey,
  }) async {
    final request = CreateWithdrawalRequest(
      amount: amount,
      paymentMethodType: 'BANK_TRANSFER',
      paymentMethodDetails: PaymentMethodDetailsRequest(iban: iban),
      idempotencyKey: idempotencyKey,
    );
    final response = await dataSource.createDoctorWithdrawal(
      request: request,
      idempotencyKey: idempotencyKey,
    );
    switch (response) {
      case Success<CreateWithdrawalResponse>():
        final data = response.data.data;
        if (data == null) {
          return const Failure('Invalid withdrawal response');
        }
        return Success(data.toEntity());
      case Failure<CreateWithdrawalResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<WalletWithdrawalEntity>> cancelDoctorWithdrawal(
    String id,
  ) async {
    final response = await dataSource.cancelDoctorWithdrawal(id);
    switch (response) {
      case Success<CreateWithdrawalResponse>():
        final data = response.data.data;
        if (data == null) {
          return const Failure('Invalid withdrawal response');
        }
        return Success(data.toEntity());
      case Failure<CreateWithdrawalResponse>():
        return Failure(response.errorMessage);
    }
  }
}
