import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/wallet/presentation/utils/doctor_withdraw_args.dart';
import 'package:tabib_app/features/wallet/presentation/view_model/doctor_withdraw_state.dart';
import 'package:tabib_app/features/wallet/presentation/view_model/doctor_withdraw_view_model.dart';
import 'package:tabib_app/features/wallet/presentation/widgets/doctor_withdraw_form.dart';

class DoctorWithdrawView extends StatelessWidget {
  final DoctorWithdrawArgs args;

  const DoctorWithdrawView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocProvider(
      create: (_) => getIt<DoctorWithdrawViewModel>(),
      child: BlocListener<DoctorWithdrawViewModel, DoctorWithdrawState>(
        listenWhen: (p, c) => p.submitState != c.submitState,
        listener: (context, state) {
          final submit = state.submitState;
          if (submit.isLoaded) {
            CustomToast.show(
              context,
              message: 'wallet.doctor.withdrawSuccess'.tr(),
              status: ToastStatus.success,
            );
            Navigator.pop(context, true);
          } else if (submit.isError) {
            final msg = submit.errorMessage ?? '';
            CustomToast.show(
              context,
              message: msg.startsWith('wallet.') ? msg.tr() : msg,
              status: ToastStatus.error,
            );
            context.read<DoctorWithdrawViewModel>().resetSubmitState();
          }
        },
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text(
              'wallet.doctor.withdraw'.tr(),
              style: theme.bold18.copyWith(color: theme.textColor600),
            ),
            backgroundColor: theme.backgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: theme.textColor600),
          ),
          body: DoctorWithdrawForm(args: args),
        ),
      ),
    );
  }
}
