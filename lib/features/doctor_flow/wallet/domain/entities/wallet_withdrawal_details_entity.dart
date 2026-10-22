import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';

class WalletWithdrawalDetailsEntity extends Equatable {
  final WalletWithdrawalEntity withdrawal;
  final List<WithdrawalRelatedTransactionEntity> transactions;

  const WalletWithdrawalDetailsEntity({
    required this.withdrawal,
    required this.transactions,
  });

  @override
  List<Object?> get props => [withdrawal, transactions];
}

class WithdrawalRelatedTransactionEntity extends Equatable {
  final String id;
  final String type;
  final double amount;
  final String? createdAt;

  const WithdrawalRelatedTransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, amount, createdAt];
}
