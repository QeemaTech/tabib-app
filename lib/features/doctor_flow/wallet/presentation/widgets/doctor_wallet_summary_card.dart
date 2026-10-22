import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/doctor_wallet_entity.dart';

class DoctorWalletSummaryCard extends StatelessWidget {
  final DoctorWalletEntity wallet;

  const DoctorWalletSummaryCard({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final currency = wallet.currency;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: 'wallet.doctor.pendingBalance'.tr(),
            value: wallet.pendingBalance,
            currency: currency,
          ),
          const SizedBox(height: 12),
          _SummaryRow(
            label: 'wallet.doctor.heldBalance'.tr(),
            value: wallet.heldBalance,
            currency: currency,
          ),
          const SizedBox(height: 12),
          _SummaryRow(
            label: 'wallet.doctor.paidOutBalance'.tr(),
            value: wallet.paidOutBalance,
            currency: currency,
          ),
          const SizedBox(height: 12),
          _SummaryRow(
            label: 'wallet.doctor.totalEarned'.tr(),
            value: wallet.totalEarned,
            currency: currency,
            emphasize: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final String currency;
  final bool emphasize;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.currency,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final formatted = NumberFormat('#,##0.##').format(value);
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
        ),
        Text(
          '$formatted $currency',
          style: (emphasize ? theme.bold18 : theme.medium16).copyWith(
            color: emphasize ? theme.primaryColor : theme.textColor600,
          ),
        ),
      ],
    );
  }
}
