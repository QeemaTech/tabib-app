import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PaymentWalletToggle extends StatelessWidget {
  final bool useWallet;
  final bool enabled;
  final double? balance;
  final String? currency;
  final ValueChanged<bool> onChanged;

  const PaymentWalletToggle({
    super.key,
    required this.useWallet,
    required this.enabled,
    required this.balance,
    required this.currency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final balanceText = balance == null
        ? '—'
        : NumberFormat('#,##0.##').format(balance);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.textColor100.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'appointments.useWallet'.tr(),
                  style: theme.medium13.copyWith(color: theme.primaryColor),
                ),
                const SizedBox(height: 4),
                Text(
                  'appointments.walletBalance'.tr(
                    namedArgs: {
                      'amount': balanceText,
                      'currency': currency ?? '',
                    },
                  ),
                  style: theme.regular12.copyWith(color: theme.textColor300),
                ),
              ],
            ),
          ),
          Switch(
            value: useWallet,
            onChanged: enabled ? onChanged : null,
            activeThumbColor: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
