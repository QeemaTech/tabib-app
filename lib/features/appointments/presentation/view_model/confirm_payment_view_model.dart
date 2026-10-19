import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/domain/entities/coupon_validation_entity.dart';
import 'package:tabib_app/features/appointments/domain/entities/payment_entity.dart';
import 'package:tabib_app/features/appointments/domain/repo/appointments_repo.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/confirm_payment_state.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_entity.dart';
import 'package:tabib_app/features/wallet/domain/repo/wallet_repo.dart';

@injectable
class ConfirmPaymentViewModel extends Cubit<ConfirmPaymentState> {
  final AppointmentsRepo appointmentsRepo;
  final WalletRepo walletRepo;

  ConfirmPaymentViewModel({
    required this.appointmentsRepo,
    required this.walletRepo,
  }) : super(const ConfirmPaymentState());

  void init({required double consultationFee}) {
    emit(
      state.copyWith(
        originalAmount: consultationFee,
        discountAmount: 0,
        finalAmount: consultationFee,
        clearAppliedCoupon: true,
        validateCouponState: BaseState.init(),
      ),
    );
  }

  Future<void> loadWallet() async {
    emit(state.copyWith(walletState: BaseState.loading()));
    final result = await walletRepo.getPatientWallet();
    switch (result) {
      case Success<WalletEntity>():
        emit(state.copyWith(walletState: BaseState.loaded(result.data)));
      case Failure<WalletEntity>():
        emit(
          state.copyWith(
            walletState: BaseState.error(result.errorMessage),
            useWallet: false,
          ),
        );
    }
  }

  Future<void> validateCoupon({
    required String code,
    required String appointmentId,
  }) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) {
      emit(
        state.copyWith(
          validateCouponState: BaseState.error(
            'appointments.couponRequired'.tr(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(validateCouponState: BaseState.loading()));
    final result = await appointmentsRepo.validateCoupon(
      code: trimmed,
      appointmentId: appointmentId,
    );
    switch (result) {
      case Success<CouponValidationEntity>():
        final coupon = result.data;
        emit(
          state.copyWith(
            validateCouponState: BaseState.loaded(coupon),
            appliedCouponCode: coupon.code,
            originalAmount: coupon.originalAmount,
            discountAmount: coupon.discountAmount,
            finalAmount: coupon.finalAmount,
          ),
        );
      case Failure<CouponValidationEntity>():
        emit(
          state.copyWith(
            validateCouponState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void clearCoupon({required double consultationFee}) {
    emit(
      state.copyWith(
        clearAppliedCoupon: true,
        originalAmount: consultationFee,
        discountAmount: 0,
        finalAmount: consultationFee,
        validateCouponState: BaseState.init(),
      ),
    );
  }

  void setUseWallet(bool value) {
    if (value && !state.walletState.isLoaded) return;
    emit(state.copyWith(useWallet: value));
  }

  void setPayerAccountNo(String value) {
    emit(state.copyWith(payerAccountNo: value.trim()));
  }

  Future<void> confirmPayment({required String appointmentId}) async {
    final payerAccountNo = state.payerAccountNo.trim();
    if (payerAccountNo.isEmpty) {
      emit(
        state.copyWith(
          paymentState: BaseState.error(
            'appointments.payerAccountRequired'.tr(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(paymentState: BaseState.loading()));
    final result = await appointmentsRepo.createPayment(
      appointmentId: appointmentId,
      couponCode: state.appliedCouponCode,
      useWallet: state.useWallet,
      payerAccountNo: payerAccountNo,
    );
    switch (result) {
      case Success<PaymentEntity>():
        emit(state.copyWith(paymentState: BaseState.loaded(result.data)));
      case Failure<PaymentEntity>():
        emit(
          state.copyWith(paymentState: BaseState.error(result.errorMessage)),
        );
    }
  }

  void resetPaymentState() {
    emit(state.copyWith(paymentState: BaseState.init()));
  }

  void resetValidateCouponError() {
    if (state.validateCouponState.isError) {
      emit(state.copyWith(validateCouponState: BaseState.init()));
    }
  }
}
