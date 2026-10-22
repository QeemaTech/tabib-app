import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoice_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_invoice_details.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_success_header.dart';

class PaymentSuccessContent extends StatelessWidget {
  final PatientInvoiceEntity invoice;

  const PaymentSuccessContent({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const PaymentSuccessHeader(),
                const SizedBox(height: 24),
                PaymentInvoiceDetails(invoice: invoice),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'appointments.done'.tr(),
                style: theme.medium16.copyWith(color: theme.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
