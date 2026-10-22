import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/entities/wallet_entity.dart';
import 'package:tabib_app/features/patient_flow/wallet/domain/repo/wallet_repo.dart';
import 'package:tabib_app/features/patient_flow/wallet/presentation/view_model/wallet_state.dart';

enum WalletRole { patient, doctor }

@injectable
class WalletViewModel extends Cubit<WalletState> {
  final PatientWalletRepo walletRepo;

  WalletViewModel({required this.walletRepo}) : super(const WalletState());

  Future<void> loadWallet(
    WalletRole role, {
    bool showLoading = true,
  }) async {
    if (role != WalletRole.patient) return;

    if (showLoading) {
      emit(state.copyWith(walletState: BaseState.loading()));
    }

    final result = await walletRepo.getPatientWallet();

    switch (result) {
      case Success<WalletEntity>():
        emit(state.copyWith(walletState: BaseState.loaded(result.data)));
      case Failure<WalletEntity>():
        emit(
          state.copyWith(
            walletState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> retry(WalletRole role) => loadWallet(role);

  Future<void> refreshWallet(WalletRole role) =>
      loadWallet(role, showLoading: false);
}
