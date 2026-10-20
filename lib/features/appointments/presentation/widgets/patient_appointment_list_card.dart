import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:tabib_app/features/appointments/presentation/utils/appointment_ui_helpers.dart';
import 'package:tabib_app/features/appointments/presentation/utils/confirm_payment_args.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointments_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/cancel_appointment_dialog.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/doctor_profile_card.dart';
import 'package:tabib_app/features/calls/presentation/utils/video_call_args.dart';

class PatientAppointmentListCard extends StatelessWidget {
  final PatientAppointmentEntity appointment;

  const PatientAppointmentListCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final doctorName = appointment.doctor.localizedName(languageCode);
    final consultationType = appointment.consultationType.toUpperCase();
    final isCallType =
        consultationType == 'VIDEO' || consultationType == 'VOICE';
    final canStartCall = appointment.status.toUpperCase() == 'CONFIRMED' &&
        isCallType &&
        appointment.actions.canAccessCall;

    return DoctorProfileCard(
      avatarUrl: appointment.doctor.avatarUrl,
      doctorName: doctorName,
      specialtyLine: appointment.doctor.specialties.isNotEmpty
          ? appointment.doctor.specialties.first
          : '',
      statusLabel: appointmentStatusLabel(appointment.status),
      specialties: appointment.doctor.specialties,
      dateTimeText: formatAppointmentDateTime(appointment),
      feeText: appointment.currency.isEmpty
          ? '${appointment.bookingPrice}'
          : '${appointment.bookingPrice} ${appointment.currency}',
      isPaid: isAppointmentPaid(appointment.actions),
      callIconPath: AssetsManager.video,
      callType: consultationType,
      onCallTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.videoCallView,
                arguments: VideoCallArgs(
                  appointmentId: appointment.id,
                  callType: consultationType,
                  peerName: doctorName,
                ),
              );
            },
      //  canStartCall
      //     ?
      //     : null,
      cancelAppointment: appointment.actions.canCancel
          ? () => showCancelAppointmentDialog(
                context,
                appointmentId: appointment.id,
              )
          : null,
      onConfirmPayment: appointment.actions.canPay
          ? () async {
              final paid = await Navigator.of(context).pushNamed(
                AppRoutes.confirmPaymentView,
                arguments: ConfirmPaymentArgs(
                  appointmentId: appointment.id,
                  bookingPrice: appointment.bookingPrice,
                  doctorName: doctorName,
                  dateTimeText: formatAppointmentDateTime(appointment),
                ),
              );
              if (paid == true && context.mounted) {
                await context
                    .read<AppointmentsViewModel>()
                    .refreshAppointments();
              }
            }
          : null,
    );
  }
}
