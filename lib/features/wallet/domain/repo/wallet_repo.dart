import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/domain/entities/doctor_wallet_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_page_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_details_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_entity.dart';

abstract interface class WalletRepo {
  Future<Result<WalletEntity>> getPatientWallet();

  Future<Result<DoctorWalletEntity>> getDoctorWallet();

  Future<Result<WalletPageEntity<WalletTransactionEntity>>>
      getDoctorTransactions({
    required int page,
    required int limit,
  });

  Future<Result<WalletPageEntity<WalletWithdrawalEntity>>>
      getDoctorWithdrawals({
    required int page,
    required int limit,
  });

  Future<Result<WalletWithdrawalDetailsEntity>> getDoctorWithdrawalById(
    String id,
  );

  Future<Result<WalletWithdrawalEntity>> createDoctorWithdrawal({
    required double amount,
    required String iban,
    required String idempotencyKey,
  });

  Future<Result<WalletWithdrawalEntity>> cancelDoctorWithdrawal(String id);
}
