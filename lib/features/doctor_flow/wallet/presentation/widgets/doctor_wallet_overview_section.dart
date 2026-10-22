import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/doctor_wallet_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/utils/doctor_withdraw_args.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_wallet_view_model.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_wallet_balance_card.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_wallet_summary_card.dart';

class DoctorWalletOverviewSection extends StatelessWidget {
  final DoctorWalletEntity wallet;

  const DoctorWalletOverviewSection({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final min = NumberFormat('#,##0.##').format(wallet.minimumWithdrawal);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        DoctorWalletBalanceCard(
          balance: wallet.availableBalance,
          currency: wallet.currency,
        ),
        const SizedBox(height: 16),
        DoctorWalletSummaryCard(wallet: wallet),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: wallet.canWithdraw
                ? () async {
                    final refreshed = await Navigator.pushNamed(
                      context,
                      AppRoutes.doctorWithdrawView,
                      arguments: DoctorWithdrawArgs(
                        availableBalance: wallet.availableBalance,
                        minimumWithdrawal: wallet.minimumWithdrawal,
                        currency: wallet.currency,
                        canWithdraw: wallet.canWithdraw,
                      ),
                    );
                    if (refreshed == true && context.mounted) {
                      context
                          .read<DoctorWalletViewModel>()
                          .refreshAfterMutation();
                    }
                  }
                : null,
            child: Text('wallet.doctor.withdraw'.tr()),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          wallet.canWithdraw
              ? 'wallet.doctor.minimumWithdrawalHint'.tr(
                  namedArgs: {'amount': min, 'currency': wallet.currency},
                )
              : 'wallet.doctor.cannotWithdraw'.tr(),
          style: theme.regular12.copyWith(color: theme.textColor300),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
