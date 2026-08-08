import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_entity.dart';
import 'package:tabib_app/features/wallet/presentation/view_model/doctor_wallet_state.dart';
import 'package:tabib_app/features/wallet/presentation/view_model/doctor_wallet_view_model.dart';
import 'package:tabib_app/features/wallet/presentation/widgets/wallet_withdrawal_tile.dart';

class DoctorWalletWithdrawalsSection extends StatelessWidget {
  const DoctorWalletWithdrawalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorWalletViewModel, DoctorWalletState>(
      buildWhen: (p, c) =>
          p.withdrawalsState != c.withdrawalsState ||
          p.isLoadingMoreWd != c.isLoadingMoreWd,
      builder: (context, state) {
        final wd = state.withdrawalsState;
        if (wd.isLoading || wd.isInitial) {
          return const _WdLoading();
        }
        if (wd.isError) {
          return _WdError(message: wd.errorMessage ?? '');
        }
        final items = wd.data ?? const [];
        if (items.isEmpty) {
          return const _WdEmpty();
        }
        return _WdList(
          items: items,
          isLoadingMore: state.isLoadingMoreWd,
          hasMore: state.wdHasMore,
        );
      },
    );
  }
}

class _WdLoading extends StatelessWidget {
  const _WdLoading();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        itemCount: 4,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, _) => const WalletWithdrawalTile(
          withdrawal: WalletWithdrawalEntity(
            id: '0',
            amount: 0,
            currency: 'KWD',
            status: 'PENDING',
            paymentMethodType: 'BANK_TRANSFER',
          ),
        ),
      ),
    );
  }
}

class _WdError extends StatelessWidget {
  final String message;

  const _WdError({required this.message});

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
                context.read<DoctorWalletViewModel>().loadWithdrawals(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _WdEmpty extends StatelessWidget {
  const _WdEmpty();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Text(
        'wallet.doctor.emptyWithdrawals'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      ),
    );
  }
}

class _WdList extends StatelessWidget {
  final List<WalletWithdrawalEntity> items;
  final bool isLoadingMore;
  final bool hasMore;

  const _WdList({
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
          context.read<DoctorWalletViewModel>().loadMoreWithdrawals();
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
          final item = items[index];
          return WalletWithdrawalTile(
            withdrawal: item,
            onTap: () async {
              final refreshed = await Navigator.pushNamed(
                context,
                AppRoutes.doctorWithdrawalDetailsView,
                arguments: item.id,
              );
              if (refreshed == true && context.mounted) {
                context.read<DoctorWalletViewModel>().refreshAfterMutation();
              }
            },
          );
        },
      ),
    );
  }
}
