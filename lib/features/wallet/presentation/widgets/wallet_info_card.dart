import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class WalletInfoCard extends StatelessWidget {
  final double balance;
  final String currency;

  const WalletInfoCard({
    super.key,
    required this.balance,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final formattedBalance = NumberFormat('#,##0.##').format(balance);

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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE4FFEB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: CustomImageView(
              imagePath: AssetsManager.moneys,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'wallet.walletSummary'.tr(),
                  style: theme.medium16.copyWith(color: theme.textColor600),
                ),
                const SizedBox(height: 4),
                Text(
                  'wallet.summaryDescription'.tr(),
                  style: theme.regular12.copyWith(color: theme.textColor300),
                ),
              ],
            ),
          ),
          Text(
            '$formattedBalance $currency',
            style: theme.bold18.copyWith(color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
