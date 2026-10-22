import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_details_entity.dart';
import 'package:tabib_app/features/doctor_flow/wallet/domain/entities/wallet_withdrawal_entity.dart';

class DoctorWithdrawalDetailsState extends Equatable {
  final BaseState<WalletWithdrawalDetailsEntity> detailsState;
  final BaseState<WalletWithdrawalEntity> cancelState;

  const DoctorWithdrawalDetailsState({
    this.detailsState = const BaseState(requestState: RequestState.init),
    this.cancelState = const BaseState(requestState: RequestState.init),
  });

  DoctorWithdrawalDetailsState copyWith({
    BaseState<WalletWithdrawalDetailsEntity>? detailsState,
    BaseState<WalletWithdrawalEntity>? cancelState,
  }) {
    return DoctorWithdrawalDetailsState(
      detailsState: detailsState ?? this.detailsState,
      cancelState: cancelState ?? this.cancelState,
    );
  }

  @override
  List<Object?> get props => [detailsState, cancelState];
}
