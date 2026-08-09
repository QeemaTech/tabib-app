import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PaymentAmountSummary extends StatelessWidget {
  final double originalAmount;
  final double discountAmount;
  final double finalAmount;

  const PaymentAmountSummary({
    super.key,
    required this.originalAmount,
    required this.discountAmount,
    required this.finalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final format = NumberFormat('#,##0.##');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _AmountRow(
            label: 'appointments.originalAmount'.tr(),
            value: format.format(originalAmount),
          ),
          if (discountAmount > 0) ...[
            const SizedBox(height: 8),
            _AmountRow(
              label: 'appointments.discount'.tr(),
              value: '- ${format.format(discountAmount)}',
            ),
          ],
          const SizedBox(height: 8),
          Divider(color: theme.textColor100.withValues(alpha: 0.3)),
          const SizedBox(height: 8),
          _AmountRow(
            label: 'appointments.finalAmount'.tr(),
            value: format.format(finalAmount),
            emphasize: true,
          ),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasize;

  const _AmountRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final style = emphasize
        ? theme.medium16.copyWith(color: theme.primaryColor)
        : theme.regular14.copyWith(color: theme.textColor300);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
