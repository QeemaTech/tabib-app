import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_card_action.dart';

class DoctorProfileCardFooter extends StatelessWidget {
  final VoidCallback? cancelAppointment;
  final VoidCallback? onConfirmPayment;
  final bool isPaid;

  const DoctorProfileCardFooter({
    super.key,
    this.cancelAppointment,
    this.onConfirmPayment,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    final showPaid = isPaid;
    final showPay = !isPaid && onConfirmPayment != null;
    final showCancel = cancelAppointment != null;
    if (!showPaid && !showPay && !showCancel) {
      return const SizedBox.shrink();
    }

    final theme = context.appTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          if (showCancel)
            Expanded(
              child: AppointmentCardAction(
                label: 'appointments.cancelAppointment'.tr(),
                foreground: theme.textColor600,
                background: theme.whiteColor,
                borderColor: theme.textColor100,
                onTap: cancelAppointment,
              ),
            ),
          if (showCancel && (showPaid || showPay)) const SizedBox(width: 12),
          if (showPaid)
            Expanded(
              child: AppointmentCardAction(
                label: 'appointments.paid'.tr(),
                foreground: theme.primaryColor,
                background: theme.primaryColor.withValues(alpha: 0.12),
              ),
            )
          else if (showPay)
            Expanded(
              child: AppointmentCardAction(
                label: 'appointments.confirmPayment'.tr(),
                foreground: theme.whiteColor,
                background: theme.primaryColor,
                onTap: onConfirmPayment,
              ),
            ),
        ],
      ),
    );
  }
}
