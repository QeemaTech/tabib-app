import 'package:equatable/equatable.dart';

class WalletTransactionEntity extends Equatable {
  final String id;
  final String type;
  final double amount;
  final String currency;
  final String? paymentId;
  final String? withdrawalId;
  final String? note;
  final Map<String, dynamic>? metadata;
  final String? createdAt;

  const WalletTransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    this.paymentId,
    this.withdrawalId,
    this.note,
    this.metadata,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        amount,
        currency,
        paymentId,
        withdrawalId,
        note,
        metadata,
        createdAt,
      ];
}
