import 'package:equatable/equatable.dart';

class DoctorWalletEntity extends Equatable {
  final String id;
  final String currency;
  final double availableBalance;
  final double pendingBalance;
  final double heldBalance;
  final double paidOutBalance;
  final double totalEarned;
  final double minimumWithdrawal;
  final bool canWithdraw;

  const DoctorWalletEntity({
    required this.id,
    required this.currency,
    required this.availableBalance,
    required this.pendingBalance,
    required this.heldBalance,
    required this.paidOutBalance,
    required this.totalEarned,
    required this.minimumWithdrawal,
    required this.canWithdraw,
  });

  @override
  List<Object?> get props => [
        id,
        currency,
        availableBalance,
        pendingBalance,
        heldBalance,
        paidOutBalance,
        totalEarned,
        minimumWithdrawal,
        canWithdraw,
      ];
}
