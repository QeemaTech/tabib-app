import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/appointments_state.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/appointments_view_model.dart';

Future<void> showCancelAppointmentDialog(
  BuildContext context, {
  required String appointmentId,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: context.read<AppointmentsViewModel>(),
      child: CancelAppointmentDialog(appointmentId: appointmentId),
    ),
  );
}

class CancelAppointmentDialog extends StatefulWidget {
  final String appointmentId;

  const CancelAppointmentDialog({
    super.key,
    required this.appointmentId,
  });

  @override
  State<CancelAppointmentDialog> createState() =>
      _CancelAppointmentDialogState();
}

class _CancelAppointmentDialogState extends State<CancelAppointmentDialog> {
  late final TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocListener<AppointmentsViewModel, AppointmentsState>(
      listenWhen: (previous, current) =>
          previous.cancelAppointmentState != current.cancelAppointmentState,
      listener: (context, state) {
        if (state.cancelAppointmentState.isLoaded && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        backgroundColor: theme.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'appointments.cancelReasonTitle'.tr(),
          style: theme.bold18.copyWith(color: theme.primaryColor),
        ),
        content: CustomTextFormField(
          controller: _reasonController,
          hintText: 'appointments.cancelReasonHint'.tr(),
          maxLines: 3,
        ),
        actions: [
          BlocBuilder<AppointmentsViewModel, AppointmentsState>(
            buildWhen: (previous, current) =>
                previous.cancelAppointmentState !=
                current.cancelAppointmentState,
            builder: (context, state) {
              final isLoading = state.cancelAppointmentState.isLoading;
              return TextButton(
                onPressed: isLoading ? null : () => Navigator.pop(context),
                child: Text(
                  'common.cancel'.tr(),
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
              );
            },
          ),
          BlocBuilder<AppointmentsViewModel, AppointmentsState>(
            buildWhen: (previous, current) =>
                previous.cancelAppointmentState !=
                current.cancelAppointmentState,
            builder: (context, state) {
              final isLoading = state.cancelAppointmentState.isLoading;
              return TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<AppointmentsViewModel>().cancelAppointment(
                              id: widget.appointmentId,
                              cancelReason: _reasonController.text,
                            );
                      },
                child: isLoading
                    ? SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.primaryColor,
                        ),
                      )
                    : Text(
                        'appointments.cancelConfirm'.tr(),
                        style: theme.bold18.copyWith(
                          color: theme.primaryColor,
                          fontSize: 14,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
