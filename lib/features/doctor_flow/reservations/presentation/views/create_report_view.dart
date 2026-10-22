import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/create_report_state.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/view_model/create_report_view_model.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/create_report_form.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/custom_expansion_tile.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/patient_report_header.dart';
import 'package:tabib_app/features/doctor_flow/reservations/presentation/widgets/report_input_widgets.dart';

class CreateReportView extends StatelessWidget {
  const CreateReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isAr = context.locale.languageCode == 'ar';
    final appointmentId =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            isAr ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: Text(
          'reservations.createReport'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
      ),
      body: BlocConsumer<CreateReportViewModel, CreateReportState>(
        listenWhen: (previous, current) =>
            previous.submitState != current.submitState,
        listener: (context, state) {
          final submitState = state.submitState;
          if (submitState.isLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('reservations.createReport'.tr())),
            );
            context.pop();
          } else if (submitState.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  submitState.errorMessage ?? 'errors.unknown'.tr(),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final detailsState = state.detailsState;
          if (detailsState.isLoading || detailsState.isInitial) {
            return const _CreateReportLoadingWidget();
          }
          if (detailsState.isError) {
            return _CreateReportErrorWidget(
              message: detailsState.errorMessage ?? '',
              appointmentId: appointmentId,
            );
          }
          final appointment = detailsState.data;
          if (appointment == null) {
            return _CreateReportErrorWidget(
              message: 'errors.unknown'.tr(),
              appointmentId: appointmentId,
            );
          }
          return CreateReportForm(appointment: appointment);
        },
      ),
    );
  }
}

class _CreateReportLoadingWidget extends StatelessWidget {
  const _CreateReportLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const PatientReportHeader(
              name: 'Patient Name',
              id: '000000',
              date: 'Date',
              time: 'Time',
              image: AssetsManager.doctor,
            ),
            const SizedBox(height: 16),
            CustomExpansionTile(
              title: 'reservations.visitInfo'.tr(),
              iconPath: AssetsManager.stethoscope,
              children: [
                ReportFieldLabel(label: 'reservations.visitType'.tr()),
                const ReportTextField(hint: 'reservations.consultation'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateReportErrorWidget extends StatelessWidget {
  final String message;
  final String appointmentId;

  const _CreateReportErrorWidget({
    required this.message,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message.isNotEmpty ? message : 'errors.unknown'.tr(),
            textAlign: TextAlign.center,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          IconButton(
            onPressed: () => context.read<CreateReportViewModel>().retry(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
