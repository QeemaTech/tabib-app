import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_consultation_mode_button.dart';
import 'package:tabib_app/features/chat/presentation/utils/chat_details_args.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_state.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_view_model.dart';
import 'package:tabib_app/features/patients/presentation/widgets/appointment_details_content.dart';
import 'package:tabib_app/features/patients/presentation/widgets/appointment_info_details.dart';
import 'package:tabib_app/features/patients/presentation/widgets/expandable_section.dart';
import 'package:tabib_app/features/patients/presentation/widgets/medical_note_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_card.dart';
import 'package:tabib_app/features/patients/presentation/widgets/patient_info_details.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointment_details_state.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointment_details_view_model.dart';

class PatientsAppointmentDetailsView extends StatelessWidget {
  const PatientsAppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final appointmentId =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return BlocProvider(
      create: (_) => getIt<StartConsultationViewModel>(),
      child: BlocListener<StartConsultationViewModel, StartConsultationState>(
        listenWhen: (previous, current) =>
            previous.startState != current.startState,
        listener: _onStartConsultation,
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            backgroundColor: theme.whiteColor,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.textColor600,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'patients.appointmentDetails.title'.tr(),
              style: theme.bold18.copyWith(color: theme.textColor600),
            ),
          ),
          body: BlocBuilder<DoctorAppointmentDetailsViewModel,
              DoctorAppointmentDetailsState>(
            builder: (context, state) {
              final detailsState = state.detailsState;
              if (detailsState.isLoading || detailsState.isInitial) {
                return const AppointmentDetailsLoadingBody();
              }
              if (detailsState.isError) {
                return _AppointmentDetailsErrorWidget(
                  message: detailsState.errorMessage ?? '',
                  appointmentId: appointmentId,
                );
              }
              final appointment = detailsState.data;
              if (appointment == null) {
                return _AppointmentDetailsErrorWidget(
                  message: 'errors.unknown'.tr(),
                  appointmentId: appointmentId,
                );
              }
              return AppointmentDetailsContent(appointment: appointment);
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
      context.read<StartConsultationViewModel>().reset();
      if (consultation == null || consultation.id.isEmpty) {
        CustomToast.error(context, 'errors.unknown'.tr());
        return;
      }
      Navigator.of(context).pushNamed(
        AppRoutes.chatDetailsView,
        arguments: ChatDetailsArgs(
          consultationId: consultation.id,
          title: consultation.patient.fullNameAr,
        ),
      );
      return;
    }
    if (startState.isError) {
      CustomToast.error(
        context,
        startState.errorMessage ?? 'errors.unknown'.tr(),
      );
      context.read<StartConsultationViewModel>().reset();
    }
  }
}

class AppointmentDetailsLoadingBody extends StatelessWidget {
  const AppointmentDetailsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PatientInfoCard(
              name: 'appointments.drName'.tr(),
              id: '232345',
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
            ExpandableSection(
              title: 'patients.appointmentDetails.patientInfo'.tr(),
              backgroundColor: const Color(0xFFE9EBF1),
              iconPath: AssetsManager.patientsActive,
              child: const PatientInfoDetails(
                gender: 'Male',
                height: '170 cm',
                weight: '70 kg',
                phone: '0500000000',
              ),
            ),
            ExpandableSection(
              title: 'patients.appointmentDetails.appointmentTime'.tr(),
              backgroundColor: const Color(0xFFE9EBF1),
              iconPath: AssetsManager.appointmentsActive,
              child: const AppointmentInfoDetails(
                date: '15 February 2026',
                time: '10:00 - 10:30',
                day: 'Saturday',
                month: 'February',
                dayNumber: '15',
              ),
            ),
            ExpandableSection(
              title: 'patients.appointmentDetails.symptoms'.tr(),
              isExpanded: true,
              backgroundColor: const Color(0xFFFEF9F0),
              iconPath: AssetsManager.document,
              child: Column(
                children: [
                  MedicalNoteCard(
                    note: 'patients.details.dummyNotes'.tr(),
                    date: '18 January, Monday',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _noop() {}

class _AppointmentDetailsErrorWidget extends StatelessWidget {
  final String message;
  final String appointmentId;

  const _AppointmentDetailsErrorWidget({
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
            message,
            textAlign: TextAlign.center,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          IconButton(
            onPressed: () => context
                .read<DoctorAppointmentDetailsViewModel>()
                .retry(appointmentId),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
