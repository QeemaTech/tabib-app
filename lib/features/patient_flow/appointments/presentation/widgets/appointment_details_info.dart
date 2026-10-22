import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/utils/appointment_ui_helpers.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_amount_row.dart';

class AppointmentDetailsInfo extends StatelessWidget {
  final PatientAppointmentDetailsEntity details;

  const AppointmentDetailsInfo({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;
    final clinic = details.doctor.clinic;
    final address = _addressLine(clinic);
    final fee = details.currency.isEmpty
        ? '${details.bookingPrice}'
        : '${details.bookingPrice} ${details.currency}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentAmountRow(
            label: 'appointments.invoiceAppointment'.tr(),
            value: formatAppointmentDetailsWhen(details),
          ),
          const SizedBox(height: 12),
          PaymentAmountRow(
            label: 'appointments.invoiceAmount'.tr(),
            value: fee,
            emphasize: true,
          ),
          if (details.channels.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'appointments.channels'.tr(),
              style: theme.medium13.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 8),
            for (final channel in details.channels) ...[
              PaymentAmountRow(
                label: channel.localizedLabel(languageCode),
                value: _channelDuration(channel),
              ),
              const SizedBox(height: 8),
            ],
          ],
          if (clinic.hasContent) ...[
            const SizedBox(height: 8),
            Text(
              'appointments.clinic'.tr(),
              style: theme.medium13.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 8),
            if (clinic.nameAr.isNotEmpty)
              Text(
                clinic.nameAr,
                style: theme.regular14.copyWith(color: theme.textColor600),
              ),
            if (address.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                address,
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
            ],
            if (clinic.phone.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                clinic.phone,
                style: theme.regular14.copyWith(color: theme.textColor300),
              ),
            ],
          ],
          if (details.complaint.isNotEmpty) ...[
            const SizedBox(height: 12),
            PaymentAmountRow(
              label: 'appointments.complaint'.tr(),
              value: details.complaint,
            ),
          ],
          if (details.symptoms.isNotEmpty) ...[
            const SizedBox(height: 12),
            PaymentAmountRow(
              label: 'appointments.symptoms'.tr(),
              value: details.symptoms,
            ),
          ],
          if (details.notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            PaymentAmountRow(
              label: 'appointments.notes'.tr(),
              value: details.notes,
            ),
          ],
        ],
      ),
    );
  }

  String _addressLine(AppointmentClinicEntity clinic) {
    final parts = [
      if (clinic.addressAr.isNotEmpty) clinic.addressAr,
      if (clinic.city.isNotEmpty) clinic.city,
    ];
    return parts.join(', ');
  }

  String _channelDuration(AppointmentChannelEntity channel) {
    if (channel.duration == 0 && channel.unit.isEmpty) return '';
    if (channel.unit.isEmpty) return '${channel.duration}';
    return '${channel.duration} ${channel.unit}';
  }
}
