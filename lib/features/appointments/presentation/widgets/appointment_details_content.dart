import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_consultation_actions.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_details_header.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_details_info.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/payment_invoice_details.dart';

class AppointmentDetailsContent extends StatelessWidget {
  final PatientAppointmentDetailsEntity details;

  const AppointmentDetailsContent({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final invoice = details.invoice;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppointmentDetailsHeader(details: details),
          const SizedBox(height: 16),
          AppointmentConsultationActions(details: details),
          const SizedBox(height: 16),
          AppointmentDetailsInfo(details: details),
          const SizedBox(height: 16),
          if (invoice != null)
            PaymentInvoiceDetails(invoice: invoice)
          else
            Text(
              'appointments.invoiceUnavailable'.tr(),
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
        ],
      ),
    );
  }
}
