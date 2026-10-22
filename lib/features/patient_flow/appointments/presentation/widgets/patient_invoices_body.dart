import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoice_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/utils/open_invoice_file.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/patient_invoices_state.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/patient_invoices_view_model.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/patient_invoices_list.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_success_error.dart';

class PatientInvoicesBody extends StatelessWidget {
  const PatientInvoicesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientInvoicesViewModel, PatientInvoicesState>(
      listenWhen: (previous, current) =>
          previous.downloadState != current.downloadState,
      listener: (context, state) async {
        final download = state.downloadState;
        if (download.isError) {
          CustomToast.error(
            context,
            download.errorMessage?.isNotEmpty == true
                ? download.errorMessage!
                : 'appointments.downloadFailed'.tr(),
          );
          return;
        }
        final file = download.data;
        if (!download.isLoaded || file == null) return;
        final opened = await saveAndOpenInvoiceFile(file);
        if (!opened && context.mounted) {
          CustomToast.error(context, 'appointments.downloadFailed'.tr());
        }
      },
      child: BlocBuilder<PatientInvoicesViewModel, PatientInvoicesState>(
        buildWhen: (previous, current) =>
            previous.invoicesState != current.invoicesState ||
            previous.isLoadingMore != current.isLoadingMore ||
            previous.hasMore != current.hasMore ||
            previous.downloadingInvoiceId != current.downloadingInvoiceId,
        builder: (context, state) {
          final invoices = state.invoicesState;
          if (invoices.isLoading || invoices.isInitial) {
            return Center(
              child: CircularProgressIndicator(
                color: context.appTheme.primaryColor,
              ),
            );
          }
          if (invoices.isError) {
            return PaymentSuccessError(
              message: invoices.errorMessage ?? '',
              onRetry: () =>
                  context.read<PatientInvoicesViewModel>().loadInvoices(),
            );
          }
          final items = invoices.data ?? const <PatientInvoiceEntity>[];
          if (items.isEmpty) {
            return RefreshIndicator(
              color: context.appTheme.primaryColor,
              onRefresh: () => context
                  .read<PatientInvoicesViewModel>()
                  .loadInvoices(showLoading: false),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    child: Center(
                      child: Text(
                        'appointments.invoicesEmpty'.tr(),
                        style: context.appTheme.regular14.copyWith(
                          color: context.appTheme.textColor300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return PatientInvoicesList(
            items: items,
            isLoadingMore: state.isLoadingMore,
            hasMore: state.hasMore,
            downloadingInvoiceId: state.downloadingInvoiceId,
          );
        },
      ),
    );
  }
}
