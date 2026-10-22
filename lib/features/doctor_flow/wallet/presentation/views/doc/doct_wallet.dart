import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/widgets/filter_chips.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/doctor_wallet_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_wallet_state.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_wallet_view_model.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_wallet_balance_card.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_wallet_overview_section.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_wallet_summary_card.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_wallet_transactions_section.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_wallet_withdrawals_section.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/wallet_header.dart';

class DocWalletView extends StatelessWidget {
  const DocWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorWalletViewModel>()..loadInitial(),
      child: const _DocWalletBody(),
    );
  }
}

class _DocWalletBody extends StatelessWidget {
  const _DocWalletBody();

  static const _sections = DoctorWalletSection.values;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WalletHeader(),
        FilterChips(
          filters: [
            'wallet.doctor.sections.overview'.tr(),
            'wallet.doctor.sections.transactions'.tr(),
            'wallet.doctor.sections.withdrawals'.tr(),
          ],
          onSelected: (index) {
            context
                .read<DoctorWalletViewModel>()
                .onSectionChanged(_sections[index]);
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<DoctorWalletViewModel, DoctorWalletState>(
            buildWhen: (p, c) => p.selectedSection != c.selectedSection,
            builder: (context, state) {
              return RefreshIndicator(
                color: theme.primaryColor,
                onRefresh: () =>
                    context.read<DoctorWalletViewModel>().refreshCurrent(),
                child: switch (state.selectedSection) {
                  DoctorWalletSection.overview => const _OverviewBody(),
                  DoctorWalletSection.transactions =>
                    const DoctorWalletTransactionsSection(),
                  DoctorWalletSection.withdrawals =>
                    const DoctorWalletWithdrawalsSection(),
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OverviewBody extends StatelessWidget {
  const _OverviewBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorWalletViewModel, DoctorWalletState>(
      buildWhen: (p, c) => p.walletState != c.walletState,
      builder: (context, state) {
        final walletState = state.walletState;
        if (walletState.isLoading || walletState.isInitial) {
          return const _OverviewLoading();
        }
        if (walletState.isError) {
          return _OverviewError(message: walletState.errorMessage ?? '');
        }
        return DoctorWalletOverviewSection(wallet: walletState.data!);
      },
    );
  }
}

class _OverviewLoading extends StatelessWidget {
  const _OverviewLoading();

  @override
  Widget build(BuildContext context) {
    const placeholder = DoctorWalletEntity(
      id: '',
      currency: 'KWD',
      availableBalance: 0,
      pendingBalance: 0,
      heldBalance: 0,
      paidOutBalance: 0,
      totalEarned: 0,
      minimumWithdrawal: 0,
      canWithdraw: false,
    );
    return Skeletonizer(
      enabled: true,
      child: ListView(
        children: const [
          DoctorWalletBalanceCard(balance: 0, currency: 'KWD'),
          SizedBox(height: 16),
          DoctorWalletSummaryCard(wallet: placeholder),
        ],
      ),
    );
  }
}

class _OverviewError extends StatelessWidget {
  final String message;

  const _OverviewError({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 240,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
                IconButton(
                  onPressed: () =>
                      context.read<DoctorWalletViewModel>().loadWallet(),
                  icon: Icon(Icons.refresh, color: theme.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
