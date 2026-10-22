import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_withdrawal_details_state.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/view_model/doctor_withdrawal_details_view_model.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/widgets/doctor_withdrawal_details_content.dart';

class DoctorWithdrawalDetailsView extends StatelessWidget {
  final String withdrawalId;

  const DoctorWithdrawalDetailsView({super.key, required this.withdrawalId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<DoctorWithdrawalDetailsViewModel>()..load(withdrawalId),
      child: _DetailsScaffold(withdrawalId: withdrawalId),
    );
  }
}

class _DetailsScaffold extends StatelessWidget {
  final String withdrawalId;

  const _DetailsScaffold({required this.withdrawalId});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocListener<DoctorWithdrawalDetailsViewModel,
        DoctorWithdrawalDetailsState>(
      listenWhen: (p, c) => p.cancelState != c.cancelState,
      listener: (context, state) {
        final cancel = state.cancelState;
        if (cancel.isLoaded) {
          CustomToast.show(
            context,
            message: 'wallet.doctor.cancelSuccess'.tr(),
            status: ToastStatus.success,
          );
          context.read<DoctorWithdrawalDetailsViewModel>().resetCancelState();
          Navigator.pop(context, true);
        } else if (cancel.isError) {
          CustomToast.show(
            context,
            message: cancel.errorMessage ?? '',
            status: ToastStatus.error,
          );
          context.read<DoctorWithdrawalDetailsViewModel>().resetCancelState();
        }
      },
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text(
            'wallet.doctor.withdrawalDetails'.tr(),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.textColor600),
        ),
        body: _DetailsBody(withdrawalId: withdrawalId),
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final String withdrawalId;

  const _DetailsBody({required this.withdrawalId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorWithdrawalDetailsViewModel,
        DoctorWithdrawalDetailsState>(
      buildWhen: (p, c) =>
          p.detailsState != c.detailsState ||
          p.cancelState.isLoading != c.cancelState.isLoading,
      builder: (context, state) {
        final details = state.detailsState;
        if (details.isLoading || details.isInitial) {
          return const _DetailsLoading();
        }
        if (details.isError) {
          return _DetailsError(
            message: details.errorMessage ?? '',
            withdrawalId: withdrawalId,
          );
        }
        return DoctorWithdrawalDetailsContent(
          data: details.data!,
          isCancelling: state.cancelState.isLoading,
        );
      },
    );
  }
}

class _DetailsLoading extends StatelessWidget {
  const _DetailsLoading();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Loading', style: context.appTheme.bold24),
          const SizedBox(height: 16),
          Text('Loading', style: context.appTheme.regular14),
        ],
      ),
    );
  }
}

class _DetailsError extends StatelessWidget {
  final String message;
  final String withdrawalId;

  const _DetailsError({required this.message, required this.withdrawalId});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          IconButton(
            onPressed: () => context
                .read<DoctorWithdrawalDetailsViewModel>()
                .load(withdrawalId),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
