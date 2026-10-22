import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/appointment_details_state.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/appointment_details_view_model.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/appointment_consultation_mode_button.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/appointment_details_content.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/payment_success_error.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/utils/chat_details_args.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/view_model/start_consultation_state.dart';
import 'package:tabib_app/features/patient_flow/chat/presentation/view_model/start_consultation_view_model.dart';

class AppointmentDetailsView extends StatelessWidget {
  final String appointmentId;

  const AppointmentDetailsView({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<AppointmentDetailsViewModel>()..loadDetails(appointmentId),
        ),
        BlocProvider(create: (_) => getIt<PatientStartConsultationViewModel>()),
      ],
      child: BlocListener<PatientStartConsultationViewModel, StartConsultationState>(
        listenWhen: (previous, current) =>
            previous.startState != current.startState,
        listener: _onStartConsultation,
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text(
              'appointments.detailsTitle'.tr(),
              style: theme.bold18.copyWith(color: theme.textColor600),
            ),
            backgroundColor: theme.backgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: theme.textColor600),
          ),
          body:
              BlocBuilder<AppointmentDetailsViewModel, AppointmentDetailsState>(
                builder: (context, state) {
                  final details = state.detailsState;
                  if (details.isLoading || details.isInitial) {
                    return const PatientAppointmentDetailsLoadingBody();
                  }
                  if (details.isError || details.data == null) {
                    return PaymentSuccessError(
                      message: details.errorMessage ?? '',
                      onRetry: () => context
                          .read<AppointmentDetailsViewModel>()
                          .loadDetails(appointmentId),
                    );
                  }
                  return AppointmentDetailsContent(details: details.data!);
                },
              ),
        ),
      ),
    );
  }

  void _onStartConsultation(
    BuildContext context,
    StartConsultationState state,
  ) {
    final startState = state.startState;
    if (startState.isLoaded) {
      final consultation = startState.data;
      context.read<PatientStartConsultationViewModel>().reset();
      if (consultation == null || consultation.id.isEmpty) {
        CustomToast.error(context, 'errors.unknown'.tr());
        return;
      }
      final details = context
          .read<AppointmentDetailsViewModel>()
          .state
          .detailsState
          .data;
      final languageCode = context.locale.languageCode;
      Navigator.of(context).pushNamed(
        AppRoutes.chatDetailsView,
        arguments: ChatDetailsArgs(
          consultationId: consultation.id,
          title: details?.doctor.localizedName(languageCode) ?? '',
          avatarUrl: details?.doctor.avatarUrl ?? '',
        ),
      );
      return;
    }
    if (startState.isError) {
      CustomToast.error(
        context,
        startState.errorMessage ?? 'errors.unknown'.tr(),
      );
      context.read<PatientStartConsultationViewModel>().reset();
    }
  }
}

class PatientAppointmentDetailsLoadingBody extends StatelessWidget {
  const PatientAppointmentDetailsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'appointments.drName'.tr(),
              style: theme.bold18.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              'appointments.typeVideo'.tr(),
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 16),
            const Row(
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
            ),
            const SizedBox(height: 16),
            Text(
              '2026-08-10 | 09:00 - 09:30',
              style: theme.regular14.copyWith(color: theme.textColor600),
            ),
            const SizedBox(height: 8),
            Text(
              '25 SAR',
              style: theme.regular14.copyWith(color: theme.textColor600),
            ),
            const SizedBox(height: 8),
            Text(
              'Headache and fever',
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
          ],
        ),
      ),
    );
  }
}

void _noop() {}
