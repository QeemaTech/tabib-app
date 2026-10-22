import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';

class DoctorWithdrawState extends Equatable {
  final BaseState<WalletWithdrawalEntity> submitState;

  const DoctorWithdrawState({
    this.submitState = const BaseState(requestState: RequestState.init),
  });

  DoctorWithdrawState copyWith({
    BaseState<WalletWithdrawalEntity>? submitState,
  }) {
    return DoctorWithdrawState(
      submitState: submitState ?? this.submitState,
    );
  }

  @override
  List<Object?> get props => [submitState];
}
