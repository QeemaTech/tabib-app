import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_invoice_entity.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/patient_invoices_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/patient_invoice_tile.dart';

class PatientInvoicesList extends StatelessWidget {
  final List<PatientInvoiceEntity> items;
  final bool isLoadingMore;
  final bool hasMore;
  final String? downloadingInvoiceId;

  const PatientInvoicesList({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.hasMore,
    required this.downloadingInvoiceId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 120 &&
            hasMore) {
          context.read<PatientInvoicesViewModel>().loadMoreInvoices();
        }
        return false;
      },
      child: RefreshIndicator(
        color: theme.primaryColor,
        onRefresh: () => context
            .read<PatientInvoicesViewModel>()
            .loadInvoices(showLoading: false),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: items.length + (isLoadingMore ? 1 : 0),
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index >= items.length) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(color: theme.primaryColor),
                ),
              );
            }
            final invoice = items[index];
            final isDownloading = downloadingInvoiceId == invoice.id;
            return PatientInvoiceTile(
              invoice: invoice,
              isDownloading: isDownloading,
              onDownload: downloadingInvoiceId == null
                  ? () => context
                        .read<PatientInvoicesViewModel>()
                        .downloadInvoice(invoice.id)
                  : null,
            );
          },
        ),
      ),
    );
  }
}
