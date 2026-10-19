import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_invoice_entity.dart';

class PatientInvoiceTile extends StatelessWidget {
  final PatientInvoiceEntity invoice;
  final bool isDownloading;
  final VoidCallback? onDownload;

  const PatientInvoiceTile({
    super.key,
    required this.invoice,
    required this.isDownloading,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final amount = NumberFormat('#,##0.##').format(invoice.amount);
    final amountText = invoice.currency.isEmpty
        ? amount
        : '$amount ${invoice.currency}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.invoiceNumber,
                  style: theme.bold18.copyWith(color: theme.primaryColor),
                ),
                if (invoice.doctorName.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    invoice.doctorName,
                    style: theme.regular14.copyWith(color: theme.textColor600),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  _appointmentWhen(invoice),
                  style: theme.regular12.copyWith(color: theme.textColor300),
                ),
                if (invoice.issuedAt.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${'appointments.invoiceIssuedAt'.tr()} ${_issuedAt(invoice.issuedAt)}',
                    style: theme.regular12.copyWith(color: theme.textColor300),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amountText,
                style: theme.medium16.copyWith(color: theme.primaryColor),
              ),
              if (isDownloading)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.primaryColor,
                    ),
                  ),
                )
              else
                IconButton(
                  onPressed: onDownload,
                  icon: Icon(
                    Icons.download_outlined,
                    color: theme.primaryColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _appointmentWhen(PatientInvoiceEntity invoice) {
    final date = invoice.appointmentDate.trim();
    final time = invoice.appointmentTime.trim();
    if (date.isEmpty) return time;
    if (time.isEmpty) return date;
    return '$date | $time';
  }

  String _issuedAt(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return DateFormat('yyyy-MM-dd HH:mm').format(parsed.toLocal());
  }
}
