import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/widgets/reservation_card.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/utils/appointment_ui_helpers.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/appointment_status_badge.dart';
import 'package:tabib_app/features/doctor_flow/home/presentation/widgets/request_review_doc.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/doctor_appointments_state.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/doctor_appointments_view_model.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/doctor_reservation_session_actions.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/doctor_reservation_summary.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/reject_appointment_dialog.dart';

class DoctorReservationListCard extends StatelessWidget {
  final DoctorAppointmentEntity appointment;
  final DoctorAppointmentsFilter filter;

  const DoctorReservationListCard({
    super.key,
    required this.appointment,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final theme = context.appTheme;
    final name = appointment.patient.localizedFullName(languageCode);
    final duration = appointmentDurationLabel(
      consultationType: appointment.consultationType,
      durationChatHours: appointment.durationChatHours,
      durationCallMinutes: appointment.durationCallMinutes,
    );
    final typeLabel = appointment.consultationType.isNotEmpty
        ? consultationTypeLabel(appointment.consultationType)
        : 'reservations.cardiologyConsultation'.tr();
    final subtitle = duration.isEmpty ? typeLabel : '$typeLabel · $duration';
    final imageUrl =
        appointment.patient.hasAvatar ? appointment.patient.avatarUrl : null;
    final statusColors = appointmentStatusColors(theme, appointment.status);
    final statusLabel = appointmentStatusLabel(appointment.status);
    final summary = DoctorReservationSummary(appointment: appointment);
    final showSession = DoctorReservationSessionActions.showsForStatus(
      appointment.status,
    );
    final sessionActions = showSession
        ? DoctorReservationSessionActions(
            appointmentId: appointment.id,
            peerName: name,
            canChat: appointment.actions.canAccessChat,
            canCall: appointment.actions.canAccessCall,
          )
        : null;

    switch (filter) {
      case DoctorAppointmentsFilter.holding:
        return BlocBuilder<DoctorAppointmentsViewModel, DoctorAppointmentsState>(
          buildWhen: (previous, current) =>
              previous.actionState != current.actionState,
          builder: (context, state) {
            return RequestReviewDocCard(
              patientName: name,
              subtitle: subtitle,
              timeLabel: '',
              imageUrl: imageUrl,
              summary: summary,
              isActionLoading: state.actionState.isLoading &&
                  state.actionAppointmentId == appointment.id,
              onAccept: () => context
                  .read<DoctorAppointmentsViewModel>()
                  .acceptAppointment(appointment.id),
              onReject: () => showRejectAppointmentDialog(
                context,
                appointmentId: appointment.id,
              ),
            );
          },
        );
      case DoctorAppointmentsFilter.confirm:
      case DoctorAppointmentsFilter.all:
        return ReservationCard(
          showTime: false,
          status: statusLabel,
          statusColor: statusColors.foreground,
          statusBackgroundColor: statusColors.background,
          doctorName: name,
          subTitle: subtitle,
          imageUrl: imageUrl,
          summary: summary,
          sessionActions: sessionActions,
          actions: [
            ReservationActionButton(
              label: 'patients.viewProfile'.tr(),
              iconPath: AssetsManager.records,
              onTap: () => _openPatientFile(context),
            ),
            ReservationActionButton(
              label: 'reservations.bookingDetails'.tr(),
              iconPath: AssetsManager.report,
              onTap: () => _openDetails(context),
            ),
          ],
        );
      case DoctorAppointmentsFilter.completed:
        return ReservationCard(
          showTime: false,
          status: statusLabel,
          statusColor: statusColors.foreground,
          statusBackgroundColor: statusColors.background,
          doctorName: name,
          subTitle: subtitle,
          imageUrl: imageUrl,
          summary: summary,
          actions: [
            ReservationActionButton(
              label: 'patients.viewProfile'.tr(),
              iconPath: AssetsManager.records,
              onTap: () => _openPatientFile(context),
            ),
            ReservationActionButton(
              label: 'reservations.createReportBtn'.tr(),
              iconPath: AssetsManager.report,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.createReportView,
                  arguments: appointment.id,
                );
              },
            ),
          ],
        );
      case DoctorAppointmentsFilter.cancel:
        return ReservationCard(
          showTime: false,
          status: statusLabel,
          statusColor: statusColors.foreground,
          statusBackgroundColor: statusColors.background,
          doctorName: name,
          subTitle: subtitle,
          imageUrl: imageUrl,
          summary: summary,
        );
    }
  }

  void _openDetails(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.patientsAppointmentDetailsView,
      arguments: appointment.id,
    );
  }

  void _openPatientFile(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.patientDetailsView,
      arguments: appointment.id,
    );
  }
}
