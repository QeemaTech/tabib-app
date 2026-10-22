import 'package:equatable/equatable.dart';

class WalletWithdrawalEntity extends Equatable {
  final String id;
  final double amount;
  final String currency;
  final String status;
  final String paymentMethodType;
  final String? iban;
  final String? bankName;
  final String? rejectionReason;
  final String? transferReference;
  final String? reviewedAt;
  final String? completedAt;
  final String? createdAt;
  final String? updatedAt;

  const WalletWithdrawalEntity({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethodType,
    this.iban,
    this.bankName,
    this.rejectionReason,
    this.transferReference,
    this.reviewedAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  bool get canCancel => status == 'PENDING';

  @override
  List<Object?> get props => [
        id,
        amount,
        currency,
        status,
        paymentMethodType,
        iban,
        bankName,
        rejectionReason,
        transferReference,
        reviewedAt,
        completedAt,
        createdAt,
        updatedAt,
      ];
}
