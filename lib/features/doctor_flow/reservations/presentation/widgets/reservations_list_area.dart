import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/widgets/reservation_card.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/appointment_card_facts.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/appointment_consultation_mode_button.dart';
import 'package:tabib_app/features/doctor_flow/home/presentation/widgets/request_review_doc.dart';
import 'package:tabib_app/features/doctor_flow/reservations/domain/entities/doctor_appointment_entity.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/doctor_appointments_state.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/doctor_appointments_view_model.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/doctor_reservation_list_card.dart';

class ReservationsListArea extends StatelessWidget {
  final DoctorAppointmentsState state;

  const ReservationsListArea({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final appointmentsState = state.appointmentsState;
    if (appointmentsState.isLoading || appointmentsState.isInitial) {
      return _ReservationsLoadingWidget(filter: state.filter);
    }
    if (appointmentsState.isError) {
      return _ReservationsErrorWidget(
        message: appointmentsState.errorMessage ?? '',
      );
    }
    final appointments = appointmentsState.data ?? const [];
    if (appointments.isEmpty) {
      return const _ReservationsEmptyWidget();
    }
    return _ReservationsSuccessWidget(
      appointments: appointments,
      filter: state.filter,
    );
  }
}

class _ReservationsLoadingWidget extends StatelessWidget {
  final DoctorAppointmentsFilter filter;

  const _ReservationsLoadingWidget({required this.filter});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemCount: 5,
        itemBuilder: (_, _) {
          if (filter == DoctorAppointmentsFilter.holding) {
            return RequestReviewDocCard(
              patientName: 'Patient Name',
              subtitle: 'Video call · 30 min',
              timeLabel: '',
              summary: const AppointmentCardFacts(
                consultationType: '',
                consultationTypeLabel: '',
                dateText: '2026-08-10',
                timeText: '09:00 - 09:30',
                durationText: '',
                feeText: '25 SAR',
                complaint: 'Headache',
              ),
            );
          }
          final showSession = filter == DoctorAppointmentsFilter.confirm ||
              filter == DoctorAppointmentsFilter.all;
          return ReservationCard(
            showTime: false,
            status: filter == DoctorAppointmentsFilter.cancel
                ? 'reservations.cancelBtn'.tr()
                : 'appointments.statusConfirmed'.tr(),
            doctorName: 'appointments.drName'.tr(),
            subTitle: 'appointments.typeVideo'.tr(),
            summary: const AppointmentCardFacts(
              consultationType: '',
              consultationTypeLabel: '',
              dateText: '2026-08-10',
              timeText: '09:00 - 09:30',
              durationText: '',
              feeText: '25 SAR',
              complaint: 'Headache',
              phone: '0500000000',
            ),
            sessionActions: showSession
                ? const Row(
                    children: [
                      Expanded(
                        child: AppointmentConsultationModeButton(
                          mode: 'CHAT',
                          enabled: true,
                          loading: false,
                          onPressed: _noop,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: AppointmentConsultationModeButton(
                          mode: 'VOICE',
                          enabled: true,
                          loading: false,
                          onPressed: _noop,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: AppointmentConsultationModeButton(
                          mode: 'VIDEO',
                          enabled: true,
                          loading: false,
                          onPressed: _noop,
                        ),
                      ),
                    ],
                  )
                : null,
            actions: filter == DoctorAppointmentsFilter.cancel
                ? null
                : [
                    ReservationActionButton(
                      label: 'patients.viewProfile'.tr(),
                      iconPath: AssetsManager.records,
                      onTap: () {},
                    ),
                    ReservationActionButton(
                      label: filter == DoctorAppointmentsFilter.completed
                          ? 'reservations.createReportBtn'.tr()
                          : 'reservations.bookingDetails'.tr(),
                      iconPath: AssetsManager.report,
                      onTap: () {},
                    ),
                  ],
          );
        },
      ),
    );
  }
}

class _ReservationsErrorWidget extends StatelessWidget {
  final String message;

  const _ReservationsErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          IconButton(
            onPressed: () =>
                context.read<DoctorAppointmentsViewModel>().retry(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _ReservationsEmptyWidget extends StatelessWidget {
  const _ReservationsEmptyWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Text(
        'appointments.empty'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      ),
    );
  }
}

class _ReservationsSuccessWidget extends StatelessWidget {
  final List<DoctorAppointmentEntity> appointments;
  final DoctorAppointmentsFilter filter;

  const _ReservationsSuccessWidget({
    required this.appointments,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: context.appTheme.primaryColor,
      onRefresh: () => context.read<DoctorAppointmentsViewModel>().refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return DoctorReservationListCard(
            appointment: appointments[index],
            filter: filter,
          );
        },
      ),
    );
  }
}

void _noop() {}
