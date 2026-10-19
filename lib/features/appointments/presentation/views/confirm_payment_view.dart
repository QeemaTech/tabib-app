import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/appointments/domain/entities/payment_entity.dart';
import 'package:tabib_app/features/appointments/presentation/utils/confirm_payment_args.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/confirm_payment_state.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/confirm_payment_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/confirm_payment_content.dart';

class ConfirmPaymentView extends StatelessWidget {
  final ConfirmPaymentArgs args;

  const ConfirmPaymentView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocProvider(
      create: (_) => getIt<ConfirmPaymentViewModel>()
        ..init(consultationFee: args.bookingPrice)
        ..loadWallet(),
      child: BlocListener<ConfirmPaymentViewModel, ConfirmPaymentState>(
        listenWhen: (previous, current) =>
            previous.paymentState != current.paymentState ||
            previous.validateCouponState != current.validateCouponState,
        listener: (context, state) {
          final vm = context.read<ConfirmPaymentViewModel>();
          if (state.paymentState.isLoaded) {
            final payment = state.paymentState.data;
            if (payment != null) {
              _handlePaymentResult(context, vm, payment);
            }
            return;
          }
          if (state.paymentState.isError) {
            CustomToast.error(context, state.paymentState.errorMessage ?? '');
            vm.resetPaymentState();
          }
          if (state.validateCouponState.isError) {
            CustomToast.error(
              context,
              state.validateCouponState.errorMessage ?? '',
            );
            vm.resetValidateCouponError();
          }
        },
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text(
              'appointments.confirmPaymentTitle'.tr(),
              style: theme.bold18.copyWith(color: theme.textColor600),
            ),
            backgroundColor: theme.backgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: theme.textColor600),
          ),
          body: ConfirmPaymentContent(args: args),
        ),
      ),
    );
  }
}

void _handlePaymentResult(
  BuildContext context,
  ConfirmPaymentViewModel viewModel,
  PaymentEntity payment,
) {
  if (payment.status.toUpperCase() == 'COMPLETED') {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.paymentSuccessView,
      arguments: payment.invoice.id,
      result: true,
    );
    return;
  }

  if (payment.paymentUrl.trim().isNotEmpty) {
    CustomToast.success(context, 'appointments.continuePayment'.tr());
  }
  viewModel.resetPaymentState();
}
