import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/utils/confirm_payment_args.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/confirm_payment_state.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/confirm_payment_view_model.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_amount_summary.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_coupon_section.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_payer_account_field.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_wallet_toggle.dart';

class ConfirmPaymentContent extends StatefulWidget {
  final ConfirmPaymentArgs args;

  const ConfirmPaymentContent({super.key, required this.args});

  @override
  State<ConfirmPaymentContent> createState() => _ConfirmPaymentContentState();
}

class _ConfirmPaymentContentState extends State<ConfirmPaymentContent> {
  late final TextEditingController _couponController;
  late final TextEditingController _payerAccountController;

  @override
  void initState() {
    super.initState();
    _couponController = TextEditingController();
    _payerAccountController = TextEditingController();
  }

  @override
  void dispose() {
    _couponController.dispose();
    _payerAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final args = widget.args;

    return BlocBuilder<ConfirmPaymentViewModel, ConfirmPaymentState>(
      builder: (context, state) {
        final vm = context.read<ConfirmPaymentViewModel>();
        final wallet = state.walletState.data;
        final coupon = state.validateCouponState.data;
        final isPaying = state.paymentState.isLoading;
        final canPay = state.payerAccountNo.isNotEmpty && !isPaying;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                args.doctorName,
                style: theme.bold18.copyWith(color: theme.primaryColor),
              ),
              const SizedBox(height: 4),
              Text(
                args.dateTimeText,
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
              const SizedBox(height: 20),
              PaymentAmountSummary(
                originalAmount: state.originalAmount,
                discountAmount: state.discountAmount,
                finalAmount: state.finalAmount,
                currency: args.currency,
              ),
              const SizedBox(height: 20),
              PaymentCouponSection(
                controller: _couponController,
                isLoading: state.validateCouponState.isLoading,
                hasAppliedCoupon: state.appliedCouponCode != null,
                discountType: coupon?.discountType,
                discountValue: coupon?.discountValue,
                onApply: () => vm.validateCoupon(
                  code: _couponController.text,
                  appointmentId: args.appointmentId,
                ),
                onClear: () {
                  _couponController.clear();
                  vm.clearCoupon(consultationFee: args.bookingPrice);
                },
              ),
              const SizedBox(height: 20),
              PaymentPayerAccountField(
                controller: _payerAccountController,
                onChanged: vm.setPayerAccountNo,
              ),
              const SizedBox(height: 20),
              PaymentWalletToggle(
                useWallet: state.useWallet,
                enabled: state.walletState.isLoaded && !isPaying,
                balance: wallet?.balance,
                currency: wallet?.currency,
                onChanged: vm.setUseWallet,
              ),
              if (state.walletState.isError) ...[
                const SizedBox(height: 8),
                Text(
                  state.walletState.errorMessage ?? '',
                  style: theme.regular12.copyWith(color: theme.textColor300),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: canPay
                      ? () =>
                            vm.confirmPayment(appointmentId: args.appointmentId)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.whiteColor,
                    disabledBackgroundColor: theme.textColor100,
                    disabledForegroundColor: theme.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isPaying
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.whiteColor,
                          ),
                        )
                      : Text(
                          'appointments.confirmPayment'.tr(),
                          style: theme.medium16.copyWith(
                            color: theme.whiteColor,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
