import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/payment_amount_row.dart';

class PaymentAmountSummary extends StatelessWidget {
  final double originalAmount;
  final double discountAmount;
  final double finalAmount;
  final String currency;

  const PaymentAmountSummary({
    super.key,
    required this.originalAmount,
    required this.discountAmount,
    required this.finalAmount,
    required this.currency,
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
          PaymentAmountRow(
            label: 'appointments.originalAmount'.tr(),
            value: _format(format, originalAmount),
          ),
          if (discountAmount > 0) ...[
            const SizedBox(height: 8),
            PaymentAmountRow(
              label: 'appointments.discount'.tr(),
              value: '- ${_format(format, discountAmount)}',
            ),
          ],
          const SizedBox(height: 8),
          Divider(color: theme.textColor100.withValues(alpha: 0.3)),
          const SizedBox(height: 8),
          PaymentAmountRow(
            label: 'appointments.finalAmount'.tr(),
            value: _format(format, finalAmount),
            emphasize: true,
          ),
        ],
      ),
    );
  }

  String _format(NumberFormat format, double amount) {
    final value = format.format(amount);
    if (currency.isEmpty) return value;
    return '$value $currency';
  }
}
