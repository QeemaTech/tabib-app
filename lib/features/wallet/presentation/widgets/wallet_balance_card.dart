import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class WalletBalanceCard extends StatelessWidget {
  final double balance;
  final String currency;

  const WalletBalanceCard({
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor,
            theme.primaryColor300,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.whiteColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomImageView(
                  imagePath: AssetsManager.emptyWallet,
                  color: theme.whiteColor,
                  height: 28,
                  width: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'wallet.availableBalance'.tr(),
                  style: theme.medium16.copyWith(color: theme.whiteColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '$formattedBalance $currency',
            style: theme.bold24.copyWith(
              color: theme.whiteColor,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'wallet.balanceHint'.tr(),
            style: theme.regular14.copyWith(
              color: theme.whiteColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
