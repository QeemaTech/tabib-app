class DoctorWithdrawArgs {
  final double availableBalance;
  final double minimumWithdrawal;
  final String currency;
  final bool canWithdraw;

  const DoctorWithdrawArgs({
    required this.availableBalance,
    required this.minimumWithdrawal,
    required this.currency,
    required this.canWithdraw,
  });
}
