import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/repo/wallet_repo.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_withdraw_state.dart';

@injectable
class DoctorWithdrawViewModel extends Cubit<DoctorWithdrawState> {
  final DoctorWalletRepo walletRepo;

  DoctorWithdrawViewModel({required this.walletRepo})
      : super(const DoctorWithdrawState());

  Future<void> submit({
    required double amount,
    required String iban,
    required double availableBalance,
    required double minimumWithdrawal,
    required bool canWithdraw,
  }) async {
    if (!canWithdraw) {
      emit(
        state.copyWith(
          submitState: BaseState.error('wallet.doctor.cannotWithdraw'),
        ),
      );
      return;
    }
    if (amount < minimumWithdrawal) {
      emit(
        state.copyWith(
          submitState: BaseState.error('wallet.doctor.amountBelowMinimum'),
        ),
      );
      return;
    }
    if (amount > availableBalance) {
      emit(
        state.copyWith(
          submitState: BaseState.error('wallet.doctor.amountExceedsBalance'),
        ),
      );
      return;
    }

    emit(state.copyWith(submitState: BaseState.loading()));
    final idempotencyKey =
        '${DateTime.now().toUtc().millisecondsSinceEpoch}-${Random().nextInt(1 << 32)}';

    final result = await walletRepo.createDoctorWithdrawal(
      amount: amount,
      iban: iban.trim(),
      idempotencyKey: idempotencyKey,
    );

    switch (result) {
      case Success<WalletWithdrawalEntity>():
        emit(state.copyWith(submitState: BaseState.loaded(result.data)));
      case Failure<WalletWithdrawalEntity>():
        emit(
          state.copyWith(submitState: BaseState.error(result.errorMessage)),
        );
    }
  }

  void resetSubmitState() {
    emit(state.copyWith(submitState: BaseState.init()));
  }
}
