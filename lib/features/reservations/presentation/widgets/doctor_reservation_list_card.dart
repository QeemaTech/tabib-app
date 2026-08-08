import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/widgets/reservation_card.dart';
import 'package:tabib_app/features/home/presentation/widgets/request_review_doc.dart';
import 'package:tabib_app/features/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointments_state.dart';

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
    final name = appointment.patient.localizedFullName(languageCode);
    final subtitle = appointment.consultationType.isNotEmpty
        ? appointment.consultationType
        : 'reservations.cardiologyConsultation'.tr();
    final time = appointment.startTime;
    final imageUrl =
        appointment.patient.hasAvatar ? appointment.patient.avatarUrl : null;

    switch (filter) {
      case DoctorAppointmentsFilter.holding:
        return RequestReviewDocCard(
          patientName: name,
          subtitle: subtitle,
          timeLabel: time,
        );
      case DoctorAppointmentsFilter.confirm:
        return ReservationCard(
          status: 'reservations.confirmedNow'.tr(),
          doctorName: name,
          subTitle: subtitle,
          time: time,
          imageUrl: imageUrl,
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
          status: 'reservations.confirmedNow'.tr(),
          doctorName: name,
          subTitle: subtitle,
          time: time,
          imageUrl: imageUrl,
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
          statusBackgroundColor: const Color(0xFFF7E4E3),
          statusColor: const Color(0xFFFF3B30),
          status: 'reservations.cancelBtn'.tr(),
          doctorName: name,
          subTitle: subtitle,
          time: time,
          imageUrl: imageUrl,
        );
      case DoctorAppointmentsFilter.all:
        return ReservationCard(
          status: 'reservations.confirmedNow'.tr(),
          doctorName: name,
          subTitle: subtitle,
          time: time,
          imageUrl: imageUrl,
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
