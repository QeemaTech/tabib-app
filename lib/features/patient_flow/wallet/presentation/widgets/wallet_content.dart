import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/entities/wallet_entity.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/view_model/wallet_state.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/view_model/wallet_view_model.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/widgets/wallet_balance_card.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/widgets/wallet_header.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/widgets/wallet_info_card.dart';

class WalletContent extends StatelessWidget {
  final WalletRole role;

  const WalletContent({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WalletViewModel>()..loadWallet(role),
      child: _WalletContentBody(role: role),
    );
  }
}

class _WalletContentBody extends StatelessWidget {
  final WalletRole role;

  const _WalletContentBody({required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletViewModel, WalletState>(
      buildWhen: (previous, current) =>
          previous.walletState != current.walletState,
      builder: (context, state) {
        final walletState = state.walletState;
        if (walletState.isLoading || walletState.isInitial) {
          return const _WalletLoadingWidget();
        }
        if (walletState.isError) {
          return _WalletErrorWidget(
            role: role,
            message: walletState.errorMessage ?? '',
          );
        }
        return _WalletSuccessWidget(role: role, wallet: walletState.data!);
      },
    );
  }
}

class _WalletLoadingWidget extends StatelessWidget {
  const _WalletLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: WalletHeader()),
          const SliverToBoxAdapter(
            child: WalletBalanceCard(balance: 0, currency: 'KWD'),
          ),
          const SliverToBoxAdapter(
            child: WalletInfoCard(balance: 0, currency: 'KWD'),
          ),
        ],
      ),
    );
  }
}

class _WalletErrorWidget extends StatelessWidget {
  final WalletRole role;
  final String message;

  const _WalletErrorWidget({
    required this.role,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<WalletViewModel>().refreshWallet(role),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: WalletHeader()),
          SliverFillRemaining(
            hasScrollBody: false,
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
                        context.read<WalletViewModel>().retry(role),
                    icon: Icon(Icons.refresh, color: theme.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletSuccessWidget extends StatelessWidget {
  final WalletRole role;
  final WalletEntity wallet;

  const _WalletSuccessWidget({
    required this.role,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<WalletViewModel>().refreshWallet(role),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: WalletHeader()),
          SliverToBoxAdapter(
            child: WalletBalanceCard(
              balance: wallet.balance,
              currency: wallet.currency,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: WalletInfoCard(
              balance: wallet.balance,
              currency: wallet.currency,
            ),
          ),
        ],
      ),
    );
  }
}
