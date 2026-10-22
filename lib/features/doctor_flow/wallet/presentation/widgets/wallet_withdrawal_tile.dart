import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/wallet_status_chip.dart';

class WalletWithdrawalTile extends StatelessWidget {
  final WalletWithdrawalEntity withdrawal;
  final VoidCallback? onTap;

  const WalletWithdrawalTile({
    super.key,
    required this.withdrawal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final amount = NumberFormat('#,##0.##').format(withdrawal.amount);
    final date = _formatDate(withdrawal.createdAt);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
                    '$amount ${withdrawal.currency}',
                    style: theme.bold18.copyWith(color: theme.textColor600),
                  ),
                ),
                WalletStatusChip(status: withdrawal.status),
              ],
            ),
            if (withdrawal.iban != null && withdrawal.iban!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                withdrawal.iban!,
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
            ],
            if (date != null) ...[
              const SizedBox(height: 6),
              Text(
                date,
                style: theme.regular12.copyWith(color: theme.textColor200),
              ),
            ],
          ],
        ),
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
