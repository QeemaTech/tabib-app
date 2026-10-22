import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_details_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/utils/wallet_labels.dart';

class DoctorWithdrawalRelatedTxTile extends StatelessWidget {
  final WithdrawalRelatedTransactionEntity tx;

  const DoctorWithdrawalRelatedTxTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final amount = NumberFormat('#,##0.##').format(tx.amount);
    final date =
        tx.createdAt == null ? null : DateTime.tryParse(tx.createdAt!);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  WalletLabels.transactionType(tx.type),
                  style: theme.medium13.copyWith(color: theme.textColor600),
                ),
                if (date != null)
                  Text(
                    DateFormat('dd MMM yyyy · HH:mm').format(date.toLocal()),
                    style: theme.regular12.copyWith(color: theme.textColor200),
                  ),
              ],
            ),
          ),
          Text(
            amount,
            style: theme.medium16.copyWith(color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
