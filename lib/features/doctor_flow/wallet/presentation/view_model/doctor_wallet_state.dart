import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/doctor_wallet_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';

enum DoctorWalletSection { overview, transactions, withdrawals }

class DoctorWalletState extends Equatable {
  final DoctorWalletSection selectedSection;
  final BaseState<DoctorWalletEntity> walletState;
  final BaseState<List<WalletTransactionEntity>> transactionsState;
  final int txPage;
  final bool txHasMore;
  final bool isLoadingMoreTx;
  final BaseState<List<WalletWithdrawalEntity>> withdrawalsState;
  final int wdPage;
  final bool wdHasMore;
  final bool isLoadingMoreWd;

  const DoctorWalletState({
    this.selectedSection = DoctorWalletSection.overview,
    this.walletState = const BaseState(requestState: RequestState.init),
    this.transactionsState = const BaseState(requestState: RequestState.init),
    this.txPage = 1,
    this.txHasMore = false,
    this.isLoadingMoreTx = false,
    this.withdrawalsState = const BaseState(requestState: RequestState.init),
    this.wdPage = 1,
    this.wdHasMore = false,
    this.isLoadingMoreWd = false,
  });

  DoctorWalletState copyWith({
    DoctorWalletSection? selectedSection,
    BaseState<DoctorWalletEntity>? walletState,
    BaseState<List<WalletTransactionEntity>>? transactionsState,
    int? txPage,
    bool? txHasMore,
    bool? isLoadingMoreTx,
    BaseState<List<WalletWithdrawalEntity>>? withdrawalsState,
    int? wdPage,
    bool? wdHasMore,
    bool? isLoadingMoreWd,
  }) {
    return DoctorWalletState(
      selectedSection: selectedSection ?? this.selectedSection,
      walletState: walletState ?? this.walletState,
      transactionsState: transactionsState ?? this.transactionsState,
      txPage: txPage ?? this.txPage,
      txHasMore: txHasMore ?? this.txHasMore,
      isLoadingMoreTx: isLoadingMoreTx ?? this.isLoadingMoreTx,
      withdrawalsState: withdrawalsState ?? this.withdrawalsState,
      wdPage: wdPage ?? this.wdPage,
      wdHasMore: wdHasMore ?? this.wdHasMore,
      isLoadingMoreWd: isLoadingMoreWd ?? this.isLoadingMoreWd,
    );
  }

  @override
  List<Object?> get props => [
        selectedSection,
        walletState,
        transactionsState,
        txPage,
        txHasMore,
        isLoadingMoreTx,
        withdrawalsState,
        wdPage,
        wdHasMore,
        isLoadingMoreWd,
      ];
}
