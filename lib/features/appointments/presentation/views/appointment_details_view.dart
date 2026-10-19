import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointment_details_state.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/appointment_details_view_model.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_details_content.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/payment_success_error.dart';

class AppointmentDetailsView extends StatelessWidget {
  final String appointmentId;

  const AppointmentDetailsView({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocProvider(
      create: (_) =>
          getIt<AppointmentDetailsViewModel>()..loadDetails(appointmentId),
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
        body: BlocBuilder<AppointmentDetailsViewModel, AppointmentDetailsState>(
          builder: (context, state) {
            final details = state.detailsState;
            if (details.isLoading || details.isInitial) {
              return Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
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
    );
  }
}
