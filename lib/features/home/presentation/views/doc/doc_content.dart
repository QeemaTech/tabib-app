import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/home/domain/entities/doctor_dashboard_entity.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_view_model.dart';
import '../../widgets/doc_info_cart.dart';
import '../../widgets/header_special.dart';
import '../../widgets/meeting_section.dart';
import '../../widgets/request_review_doc.dart';
import '../../widgets/search_bar_widget.dart';

class DocContent extends StatelessWidget {
  const DocContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDashboardViewModel, DoctorDashboardState>(
      buildWhen: (previous, current) =>
          previous.dashboardState != current.dashboardState,
      builder: (context, state) {
        final dashboardState = state.dashboardState;

        if (dashboardState.isLoading || dashboardState.isInitial) {
          return const _DocContentLoadingWidget();
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

        return _DocContentSuccessWidget(dashboard: dashboard);
      },
    );
  }
}

class _DocContentLoadingWidget extends StatelessWidget {
  const _DocContentLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.appTheme.primaryColor,strokeWidth: 2,),
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

  const _DocContentSuccessWidget({required this.dashboard});

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
            title: "home.doctor.reviewRequests",
            titleArgs: ["${dashboard.stats.pendingCount}"],
          ),
          ...dashboard.pendingRequests.map(
            (request) => RequestReviewDocCard(
              patientName: request.patient.fullNameAr,
              subtitle: request.consultationType,
              timeLabel: '${request.date} - ${request.startTime}',
            ),
          ),
        ],
      ),
    );
  }
}
