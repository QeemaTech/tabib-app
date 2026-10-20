import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointment_details_state.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointment_details_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_details_content.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/payment_success_error.dart';
import 'package:tabib_app/features/chat/presentation/utils/chat_details_args.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_state.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_view_model.dart';

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
        BlocProvider(create: (_) => getIt<StartConsultationViewModel>()),
      ],
      child: BlocListener<StartConsultationViewModel, StartConsultationState>(
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
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    );
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
      context.read<StartConsultationViewModel>().reset();
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
      context.read<StartConsultationViewModel>().reset();
    }
  }
}
