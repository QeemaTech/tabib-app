import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_entity.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_stats_entity.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_view_model.dart';
import 'package:tabib_app/features/home/presentation/widgets/dashboard_reject_dialog.dart';
import 'package:tabib_app/features/home/presentation/widgets/doc_info_cart.dart';
import 'package:tabib_app/features/home/presentation/widgets/header_special.dart';
import 'package:tabib_app/features/home/presentation/widgets/meeting_section.dart';
import 'package:tabib_app/features/home/presentation/widgets/request_review_doc.dart';
import 'package:tabib_app/features/home/presentation/widgets/search_bar_widget.dart';

class DocContent extends StatelessWidget {
  const DocContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorDashboardViewModel, DoctorDashboardState>(
      listenWhen: (previous, current) =>
          previous.actionState != current.actionState,
      listener: (context, state) {
        final action = state.actionState;
        if (action.isLoaded) {
          final message = action.data == DashboardPendingActionType.reject
              ? 'reservations.rejectSuccess'.tr()
              : 'reservations.acceptSuccess'.tr();
          CustomToast.show(
            context,
            message: message,
            status: ToastStatus.success,
          );
          context.read<DoctorDashboardViewModel>().resetActionState();
        } else if (action.isError) {
          CustomToast.show(
            context,
            message: action.errorMessage ?? 'errors.unknown'.tr(),
            status: ToastStatus.error,
          );
          context.read<DoctorDashboardViewModel>().resetActionState();
        }
      },
      child: BlocBuilder<DoctorDashboardViewModel, DoctorDashboardState>(
        builder: (context, state) {
          final dashboardState = state.dashboardState;

          if (dashboardState.isLoading || dashboardState.isInitial) {
            return const DocHomeLoadingBody();
          }

          if (dashboardState.isError) {
            return _DocContentErrorWidget(
              message: dashboardState.errorMessage ?? '',
            );
          }

          final dashboard = dashboardState.data;
          if (dashboard == null) {
            return const SizedBox.shrink();
          }

          return _DocContentSuccessWidget(
            dashboard: dashboard,
            actionAppointmentId: state.actionAppointmentId,
            isActionLoading: state.actionState.isLoading,
          );
        },
      ),
    );
  }
}

class DocHomeLoadingBody extends StatelessWidget {
  const DocHomeLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            const SearchBarWidget(),
            DocDashboard(
              stats: const DoctorDashboardStatsEntity(
                todayCount: 4,
                weekCount: 12,
                completedCount: 8,
                totalCompletedCount: 20,
                pendingCount: 2,
                rating: 4.8,
                ratingCount: 16,
                earnings: 250,
              ),
            ),
            const MeetingSection(patientName: 'Patient Name'),
            HeaderSpecial(
              title: 'home.doctor.reviewRequests',
              titleArgs: const ['2'],
            ),
            const RequestReviewDocCard(
              patientName: 'Patient Name',
              subtitle: 'Video call',
              timeLabel: '2026-08-10 | 09:30',
            ),
          ],
        ),
      ),
    );
  }
}

class _DocContentErrorWidget extends StatelessWidget {
  final String message;

  const _DocContentErrorWidget({required this.message});

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
          const SizedBox(height: 12),
          IconButton(
            onPressed: () =>
                context.read<DoctorDashboardViewModel>().loadDashboard(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _DocContentSuccessWidget extends StatelessWidget {
  final DoctorDashboardEntity dashboard;
  final String? actionAppointmentId;
  final bool isActionLoading;

  const _DocContentSuccessWidget({
    required this.dashboard,
    required this.actionAppointmentId,
    required this.isActionLoading,
  });

  @override
  Widget build(BuildContext context) {
    final firstAppointment = dashboard.todayAppointments.isNotEmpty
        ? dashboard.todayAppointments.first
        : null;
    final patientName = firstAppointment?.patient.fullNameAr;

    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          const SearchBarWidget(),
          DocDashboard(stats: dashboard.stats),
          MeetingSection(patientName: patientName),
          HeaderSpecial(
            title: 'home.doctor.reviewRequests',
            titleArgs: ['${dashboard.stats.pendingCount}'],
          ),
          ...dashboard.pendingRequests.map(
            (request) => RequestReviewDocCard(
              patientName: request.patient.fullNameAr,
              subtitle: request.consultationType,
              timeLabel: '${request.date} - ${request.startTime}',
              imageUrl: request.patient.avatarUrl,
              isActionLoading:
                  isActionLoading && actionAppointmentId == request.id,
              onAccept: () => context
                  .read<DoctorDashboardViewModel>()
                  .acceptAppointment(request.id),
              onReject: () => showDashboardRejectDialog(
                context,
                appointmentId: request.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
