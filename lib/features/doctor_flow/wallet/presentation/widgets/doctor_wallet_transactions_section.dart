import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_wallet_state.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_wallet_view_model.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/wallet_transaction_tile.dart';

class DoctorWalletTransactionsSection extends StatelessWidget {
  const DoctorWalletTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorWalletViewModel, DoctorWalletState>(
      buildWhen: (p, c) =>
          p.transactionsState != c.transactionsState ||
          p.isLoadingMoreTx != c.isLoadingMoreTx,
      builder: (context, state) {
        final tx = state.transactionsState;
        if (tx.isLoading || tx.isInitial) {
          return const _TxLoading();
        }
        if (tx.isError) {
          return _TxError(message: tx.errorMessage ?? '');
        }
        final items = tx.data ?? const [];
        if (items.isEmpty) {
          return const _TxEmpty();
        }
        return _TxList(
          items: items,
          isLoadingMore: state.isLoadingMoreTx,
          hasMore: state.txHasMore,
        );
      },
    );
  }
}

class _TxLoading extends StatelessWidget {
  const _TxLoading();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        itemCount: 4,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, _) => WalletTransactionTile(
          transaction: WalletTransactionEntity(
            id: '0',
            type: 'EARNING',
            amount: 0,
            currency: 'KWD',
          ),
        ),
      ),
    );
  }
}

class _TxError extends StatelessWidget {
  final String message;

  const _TxError({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
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
                context.read<DoctorWalletViewModel>().loadTransactions(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _TxEmpty extends StatelessWidget {
  const _TxEmpty();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Text(
        'wallet.doctor.emptyTransactions'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      ),
    );
  }
}

class _TxList extends StatelessWidget {
  final List<WalletTransactionEntity> items;
  final bool isLoadingMore;
  final bool hasMore;

  const _TxList({
    required this.items,
    required this.isLoadingMore,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n.metrics.pixels >= n.metrics.maxScrollExtent - 120 && hasMore) {
          context.read<DoctorWalletViewModel>().loadMoreTransactions();
        }
        return false;
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              ),
            );
          }
          return WalletTransactionTile(transaction: items[index]);
        },
      ),
    );
  }
}
