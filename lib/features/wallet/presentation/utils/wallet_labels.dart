import 'package:easy_localization/easy_localization.dart';

class WalletLabels {
  WalletLabels._();

  static String transactionType(String type) {
    return switch (type) {
      'EARNING' => 'wallet.doctor.txTypes.earning'.tr(),
      'ADJUSTMENT' => 'wallet.doctor.txTypes.adjustment'.tr(),
      'WITHDRAWAL_HOLD' => 'wallet.doctor.txTypes.withdrawalHold'.tr(),
      'WITHDRAWAL_RELEASE' => 'wallet.doctor.txTypes.withdrawalRelease'.tr(),
      'PAYOUT_COMPLETED' => 'wallet.doctor.txTypes.payoutCompleted'.tr(),
      _ => type,
    };
  }

  static String withdrawalStatus(String status) {
    return switch (status) {
      'PENDING' => 'wallet.doctor.statuses.pending'.tr(),
      'APPROVED' => 'wallet.doctor.statuses.approved'.tr(),
      'PROCESSING' => 'wallet.doctor.statuses.processing'.tr(),
      'COMPLETED' => 'wallet.doctor.statuses.completed'.tr(),
      'REJECTED' => 'wallet.doctor.statuses.rejected'.tr(),
      'FAILED' => 'wallet.doctor.statuses.failed'.tr(),
      'CANCELLED' => 'wallet.doctor.statuses.cancelled'.tr(),
      _ => status,
    };
  }

  static bool isDebitType(String type) {
    return type == 'WITHDRAWAL_HOLD' || type == 'PAYOUT_COMPLETED';
  }
}
