import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/entities/wallet_entity.dart';

class WalletState extends Equatable {
  final BaseState<WalletEntity> walletState;

  const WalletState({
    this.walletState = const BaseState(requestState: RequestState.init),
  });

  WalletState copyWith({
    BaseState<WalletEntity>? walletState,
  }) {
    return WalletState(
      walletState: walletState ?? this.walletState,
    );
  }

  @override
  List<Object?> get props => [walletState];
}
