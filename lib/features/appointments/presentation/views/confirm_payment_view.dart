import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/appointments/domain/entities/payment_entity.dart';
import 'package:tabib_app/features/appointments/presentation/utils/confirm_payment_args.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/confirm_payment_state.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/confirm_payment_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/confirm_payment_content.dart';
import 'package:url_launcher/url_launcher.dart';

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

Future<void> _handlePaymentResult(
  BuildContext context,
  ConfirmPaymentViewModel viewModel,
  PaymentEntity payment,
) async {
  if (payment.status.toUpperCase() == 'COMPLETED') {
    final invoiceUrl = payment.paymentUrl.trim().isNotEmpty
        ? payment.paymentUrl.trim()
        : payment.invoice.pdfUrl.trim();
    final opened = await _openUrl(invoiceUrl, preferInApp: true);
    if (opened) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
    }
    if (!context.mounted) return;
    if (opened) {
      CustomToast.success(context, 'appointments.paySuccess'.tr());
    } else if (invoiceUrl.isEmpty) {
      CustomToast.success(context, 'appointments.paySuccess'.tr());
    } else {
      CustomToast.error(context, 'appointments.invoiceOpenFailed'.tr());
    }
    Navigator.pop(context, true);
    return;
  }

  final url = payment.paymentUrl.trim();
  if (url.isNotEmpty) {
    final opened = await _openUrl(url, preferInApp: false);
    if (!context.mounted) return;
    if (opened) {
      CustomToast.success(context, 'appointments.continuePayment'.tr());
    } else {
      CustomToast.error(context, 'appointments.invoiceOpenFailed'.tr());
    }
  }
  viewModel.resetPaymentState();
}

Future<bool> _openUrl(String url, {required bool preferInApp}) async {
  final uri = _httpUri(url);
  if (uri == null) return false;
  final isPdf = uri.path.toLowerCase().endsWith('.pdf');
  try {
    if (preferInApp && !isPdf) {
      final opened = await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      if (opened) return true;
    }
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  } on Object {
    return false;
  }
}

Uri? _httpUri(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return null;
  final withScheme = trimmed.contains('://') ? trimmed : 'https://$trimmed';
  final uri = Uri.tryParse(withScheme);
  if (uri == null) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;
  if (uri.host.isEmpty) return null;
  return uri;
}
