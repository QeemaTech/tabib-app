import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/payment_success_state.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/payment_success_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/payment_success_content.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/payment_success_error.dart';

class PaymentSuccessView extends StatelessWidget {
  final String invoiceId;

  const PaymentSuccessView({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocProvider(
      create: (_) => getIt<PaymentSuccessViewModel>()..loadInvoice(invoiceId),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text(
            'appointments.paymentSuccessTitle'.tr(),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.textColor600),
        ),
        body: BlocBuilder<PaymentSuccessViewModel, PaymentSuccessState>(
          builder: (context, state) {
            final invoice = state.invoiceState;
            if (invoice.isLoading || invoice.isInitial) {
              return Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              );
            }
            if (invoice.isError || invoice.data == null) {
              return PaymentSuccessError(
                message: invoice.errorMessage ?? '',
                onRetry: () => context
                    .read<PaymentSuccessViewModel>()
                    .loadInvoice(invoiceId),
              );
            }
            return PaymentSuccessContent(invoice: invoice.data!);
          },
        ),
      ),
    );
  }
}
