import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_invoice_entity.dart';
import 'package:tabib_app/features/appointments/presentation/utils/appointment_ui_helpers.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/payment_amount_row.dart';

class PaymentInvoiceDetails extends StatelessWidget {
  final PatientInvoiceEntity invoice;

  const PaymentInvoiceDetails({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final amount = NumberFormat('#,##0.##').format(invoice.amount);
    final amountText = invoice.currency.isEmpty
        ? amount
        : '$amount ${invoice.currency}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          PaymentAmountRow(
            label: 'appointments.invoiceNumber'.tr(),
            value: invoice.invoiceNumber,
          ),
          const SizedBox(height: 12),
          PaymentAmountRow(
            label: 'appointments.invoiceAmount'.tr(),
            value: amountText,
            emphasize: true,
          ),
          const SizedBox(height: 12),
          PaymentAmountRow(
            label: 'appointments.invoiceDoctor'.tr(),
            value: invoice.doctorName,
          ),
          const SizedBox(height: 12),
          PaymentAmountRow(
            label: 'appointments.invoiceAppointment'.tr(),
            value: _appointmentWhen(invoice),
          ),
          const SizedBox(height: 12),
          PaymentAmountRow(
            label: 'appointments.invoiceStatus'.tr(),
            value: appointmentStatusLabel(invoice.appointmentStatus),
          ),
          const SizedBox(height: 12),
          PaymentAmountRow(
            label: 'appointments.invoiceIssuedAt'.tr(),
            value: _issuedAt(invoice.issuedAt),
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
