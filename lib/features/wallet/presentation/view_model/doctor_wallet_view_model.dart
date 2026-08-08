import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/domain/entities/doctor_wallet_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_page_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_entity.dart';
import 'package:tabib_app/features/wallet/domain/repo/wallet_repo.dart';
import 'package:tabib_app/features/wallet/presentation/view_model/doctor_wallet_state.dart';

@injectable
class DoctorWalletViewModel extends Cubit<DoctorWalletState> {
  final WalletRepo walletRepo;
  static const int _pageLimit = 20;

  DoctorWalletViewModel({required this.walletRepo})
      : super(const DoctorWalletState());

  Future<void> loadInitial() async {
    await loadWallet();
  }

  void onSectionChanged(DoctorWalletSection section) {
    if (state.selectedSection == section) return;
    emit(state.copyWith(selectedSection: section));
    switch (section) {
      case DoctorWalletSection.overview:
        if (state.walletState.isInitial) loadWallet();
      case DoctorWalletSection.transactions:
        if (state.transactionsState.isInitial) loadTransactions();
      case DoctorWalletSection.withdrawals:
        if (state.withdrawalsState.isInitial) loadWithdrawals();
    }
  }

  Future<void> loadWallet({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(walletState: BaseState.loading()));
    }
    final result = await walletRepo.getDoctorWallet();
    switch (result) {
      case Success<DoctorWalletEntity>():
        emit(state.copyWith(walletState: BaseState.loaded(result.data)));
      case Failure<DoctorWalletEntity>():
        emit(
          state.copyWith(walletState: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> loadTransactions({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(transactionsState: BaseState.loading()));
    }
    final result = await walletRepo.getDoctorTransactions(
      page: 1,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<WalletPageEntity<WalletTransactionEntity>>():
        emit(
          state.copyWith(
            transactionsState: BaseState.loaded(result.data.items),
            txPage: result.data.page,
            txHasMore: result.data.hasMore,
            isLoadingMoreTx: false,
          ),
        );
      case Failure<WalletPageEntity<WalletTransactionEntity>>():
        emit(
          state.copyWith(
            transactionsState: BaseState.error(result.errorMessage),
            isLoadingMoreTx: false,
          ),
        );
    }
  }

  Future<void> loadMoreTransactions() async {
    if (!state.txHasMore || state.isLoadingMoreTx) return;
    emit(state.copyWith(isLoadingMoreTx: true));
    final nextPage = state.txPage + 1;
    final result = await walletRepo.getDoctorTransactions(
      page: nextPage,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<WalletPageEntity<WalletTransactionEntity>>():
        final current = state.transactionsState.data ?? const [];
        emit(
          state.copyWith(
            transactionsState: BaseState.loaded([
              ...current,
              ...result.data.items,
            ]),
            txPage: result.data.page,
            txHasMore: result.data.hasMore,
            isLoadingMoreTx: false,
          ),
        );
      case Failure<WalletPageEntity<WalletTransactionEntity>>():
        emit(state.copyWith(isLoadingMoreTx: false));
    }
  }

  Future<void> loadWithdrawals({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(withdrawalsState: BaseState.loading()));
    }
    final result = await walletRepo.getDoctorWithdrawals(
      page: 1,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<WalletPageEntity<WalletWithdrawalEntity>>():
        emit(
          state.copyWith(
            withdrawalsState: BaseState.loaded(result.data.items),
            wdPage: result.data.page,
            wdHasMore: result.data.hasMore,
            isLoadingMoreWd: false,
          ),
        );
      case Failure<WalletPageEntity<WalletWithdrawalEntity>>():
        emit(
          state.copyWith(
            withdrawalsState: BaseState.error(result.errorMessage),
            isLoadingMoreWd: false,
          ),
        );
    }
  }

  Future<void> loadMoreWithdrawals() async {
    if (!state.wdHasMore || state.isLoadingMoreWd) return;
    emit(state.copyWith(isLoadingMoreWd: true));
    final nextPage = state.wdPage + 1;
    final result = await walletRepo.getDoctorWithdrawals(
      page: nextPage,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<WalletPageEntity<WalletWithdrawalEntity>>():
        final current = state.withdrawalsState.data ?? const [];
        emit(
          state.copyWith(
            withdrawalsState: BaseState.loaded([
              ...current,
              ...result.data.items,
            ]),
            wdPage: result.data.page,
            wdHasMore: result.data.hasMore,
            isLoadingMoreWd: false,
          ),
        );
      case Failure<WalletPageEntity<WalletWithdrawalEntity>>():
        emit(state.copyWith(isLoadingMoreWd: false));
    }
  }

  Future<void> refreshCurrent() async {
    switch (state.selectedSection) {
      case DoctorWalletSection.overview:
        await loadWallet(showLoading: false);
      case DoctorWalletSection.transactions:
        await loadTransactions(showLoading: false);
      case DoctorWalletSection.withdrawals:
        await loadWithdrawals(showLoading: false);
    }
  }

  Future<void> refreshAfterMutation() async {
    await Future.wait([
      loadWallet(showLoading: false),
      loadTransactions(showLoading: false),
      loadWithdrawals(showLoading: false),
    ]);
  }
}
