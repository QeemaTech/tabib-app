import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointments_state.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointments_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/doctor_profile_card.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/patient_appointment_list_card.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppointmentsViewModel>()..loadAppointments(),
      child: const AppointmentsViewBody(),
    );
  }
}

class AppointmentsViewBody extends StatelessWidget {
  const AppointmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentsViewModel, AppointmentsState>(
      listenWhen: (previous, current) =>
          previous.cancelAppointmentState != current.cancelAppointmentState,
      listener: (context, state) {
        final cancelState = state.cancelAppointmentState;
        if (cancelState.isLoaded) {
          CustomToast.success(context, 'appointments.cancelSuccess'.tr());
        }
        if (cancelState.isError) {
          CustomToast.error(context, cancelState.errorMessage ?? '');
        }
      },
      child: BlocBuilder<AppointmentsViewModel, AppointmentsState>(
        buildWhen: (previous, current) =>
            previous.appointmentsState != current.appointmentsState,
        builder: (context, state) {
          final appointmentsState = state.appointmentsState;
          if (appointmentsState.isLoading || appointmentsState.isInitial) {
            return const _AppointmentsLoadingWidget();
          }
          if (appointmentsState.isError) {
            return _AppointmentsErrorWidget(
              message: appointmentsState.errorMessage ?? '',
            );
          }
          return _AppointmentsSuccessWidget(
            appointments: appointmentsState.data ?? const [],
          );
        },
      ),
    );
  }
}

class _AppointmentsLoadingWidget extends StatelessWidget {
  const _AppointmentsLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: 3,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (_, _) => const DoctorProfileCard(
              avatarUrl: '',
              doctorName: 'Doctor Name',
              specialtyLine: 'Specialty',
              status: 'CONFIRMED',
              statusLabel: 'Confirmed',
              specialties: ['Specialty One', 'Specialty Two'],
              consultationType: 'VIDEO',
              consultationTypeLabel: 'Video call',
              dateText: '2026-07-18',
              timeText: '09:00 - 09:30',
              durationText: '30 min',
              feeText: '25',
              complaint: 'Complaint',
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentsErrorWidget extends StatelessWidget {
  final String message;

  const _AppointmentsErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () =>
          context.read<AppointmentsViewModel>().refreshAppointments(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
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
                        context.read<AppointmentsViewModel>().retry(),
                    icon: Icon(Icons.refresh, color: theme.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentsSuccessWidget extends StatelessWidget {
  final List<PatientAppointmentEntity> appointments;

  const _AppointmentsSuccessWidget({required this.appointments});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () =>
          context.read<AppointmentsViewModel>().refreshAppointments(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (appointments.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'appointments.empty'.tr(),
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
              ),
            )
          else
            SliverList.separated(
              itemCount: appointments.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return PatientAppointmentListCard(
                  appointment: appointments[index],
                );
              },
            ),
        ],
      ),
    );
  }
}
