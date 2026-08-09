import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/appointments/domain/entities/coupon_validation_entity.dart';
import 'package:tabib_app/features/appointments/domain/entities/payment_entity.dart';
import 'package:tabib_app/features/wallet/domain/entities/wallet_entity.dart';

class ConfirmPaymentState extends Equatable {
  final BaseState<WalletEntity> walletState;
  final BaseState<CouponValidationEntity> validateCouponState;
  final BaseState<PaymentEntity> paymentState;
  final double originalAmount;
  final double discountAmount;
  final double finalAmount;
  final String? appliedCouponCode;
  final bool useWallet;

  const ConfirmPaymentState({
    this.walletState = const BaseState(requestState: RequestState.init),
    this.validateCouponState =
        const BaseState(requestState: RequestState.init),
    this.paymentState = const BaseState(requestState: RequestState.init),
    this.originalAmount = 0,
    this.discountAmount = 0,
    this.finalAmount = 0,
    this.appliedCouponCode,
    this.useWallet = false,
  });

  ConfirmPaymentState copyWith({
    BaseState<WalletEntity>? walletState,
    BaseState<CouponValidationEntity>? validateCouponState,
    BaseState<PaymentEntity>? paymentState,
    double? originalAmount,
    double? discountAmount,
    double? finalAmount,
    String? appliedCouponCode,
    bool clearAppliedCoupon = false,
    bool? useWallet,
  }) {
    return ConfirmPaymentState(
      walletState: walletState ?? this.walletState,
      validateCouponState: validateCouponState ?? this.validateCouponState,
      paymentState: paymentState ?? this.paymentState,
      originalAmount: originalAmount ?? this.originalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      finalAmount: finalAmount ?? this.finalAmount,
      appliedCouponCode: clearAppliedCoupon
          ? null
          : (appliedCouponCode ?? this.appliedCouponCode),
      useWallet: useWallet ?? this.useWallet,
    );
  }

  @override
  List<Object?> get props => [
        walletState,
        validateCouponState,
        paymentState,
        originalAmount,
        discountAmount,
        finalAmount,
        appliedCouponCode,
        useWallet,
      ];
}
