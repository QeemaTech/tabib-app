import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/utils/wallet_labels.dart';

class WalletTransactionTile extends StatelessWidget {
  final WalletTransactionEntity transaction;

  const WalletTransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isDebit = WalletLabels.isDebitType(transaction.type);
    final amount = NumberFormat('#,##0.##').format(transaction.amount);
    final sign = isDebit ? '-' : '+';
    final date = _formatDate(transaction.createdAt);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  WalletLabels.transactionType(transaction.type),
                  style: theme.medium16.copyWith(color: theme.textColor600),
                ),
              ),
              Text(
                '$sign$amount ${transaction.currency}',
                style: theme.bold18.copyWith(
                  color: isDebit ? theme.textColor300 : theme.primaryColor,
                ),
              ),
            ],
          ),
          if (date != null) ...[
            const SizedBox(height: 6),
            Text(
              date,
              style: theme.regular12.copyWith(color: theme.textColor200),
            ),
          ],
          if (transaction.note != null && transaction.note!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              transaction.note!,
              style: theme.regular12.copyWith(color: theme.textColor300),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  String? _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return DateFormat('dd MMM yyyy · HH:mm').format(parsed.toLocal());
  }
}
