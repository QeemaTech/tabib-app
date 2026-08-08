import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_details_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_withdrawal_entity.dart';
import 'package:tabib_app/features/wallet/domain/repo/wallet_repo.dart';
import 'package:tabib_app/features/wallet/presentation/view_model/doctor_withdrawal_details_state.dart';

@injectable
class DoctorWithdrawalDetailsViewModel
    extends Cubit<DoctorWithdrawalDetailsState> {
  final WalletRepo walletRepo;

  DoctorWithdrawalDetailsViewModel({required this.walletRepo})
      : super(const DoctorWithdrawalDetailsState());

  Future<void> load(String id, {bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(detailsState: BaseState.loading()));
    }
    final result = await walletRepo.getDoctorWithdrawalById(id);
    switch (result) {
      case Success<WalletWithdrawalDetailsEntity>():
        emit(state.copyWith(detailsState: BaseState.loaded(result.data)));
      case Failure<WalletWithdrawalDetailsEntity>():
        emit(
          state.copyWith(detailsState: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> cancel(String id) async {
    emit(state.copyWith(cancelState: BaseState.loading()));
    final result = await walletRepo.cancelDoctorWithdrawal(id);
    switch (result) {
      case Success<WalletWithdrawalEntity>():
        emit(state.copyWith(cancelState: BaseState.loaded(result.data)));
        await load(id, showLoading: false);
      case Failure<WalletWithdrawalEntity>():
        emit(
          state.copyWith(cancelState: BaseState.error(result.errorMessage)),
        );
    }
  }

  void resetCancelState() {
    emit(state.copyWith(cancelState: BaseState.init()));
  }
}
