import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointments_state.dart';
import 'package:tabib_app/features/reservations/presentation/view_model/doctor_appointments_view_model.dart';

Future<void> showRejectAppointmentDialog(
  BuildContext context, {
  required String appointmentId,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: context.read<DoctorAppointmentsViewModel>(),
      child: RejectAppointmentDialog(appointmentId: appointmentId),
    ),
  );
}

class RejectAppointmentDialog extends StatefulWidget {
  final String appointmentId;

  const RejectAppointmentDialog({
    super.key,
    required this.appointmentId,
  });

  @override
  State<RejectAppointmentDialog> createState() =>
      _RejectAppointmentDialogState();
}

class _RejectAppointmentDialogState extends State<RejectAppointmentDialog> {
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

    return BlocListener<DoctorAppointmentsViewModel, DoctorAppointmentsState>(
      listenWhen: (previous, current) =>
          previous.actionState != current.actionState,
      listener: (context, state) {
        if (state.actionState.isLoaded && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        backgroundColor: theme.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'reservations.rejectReasonTitle'.tr(),
          style: theme.bold18.copyWith(color: theme.primaryColor),
        ),
        content: CustomTextFormField(
          controller: _reasonController,
          hintText: 'reservations.rejectReasonHint'.tr(),
          maxLines: 3,
        ),
        actions: [
          BlocBuilder<DoctorAppointmentsViewModel, DoctorAppointmentsState>(
            buildWhen: (p, c) => p.actionState != c.actionState,
            builder: (context, state) {
              final isLoading = state.actionState.isLoading;
              return TextButton(
                onPressed: isLoading ? null : () => Navigator.pop(context),
                child: Text(
                  'common.cancel'.tr(),
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
              );
            },
          ),
          BlocBuilder<DoctorAppointmentsViewModel, DoctorAppointmentsState>(
            buildWhen: (p, c) => p.actionState != c.actionState,
            builder: (context, state) {
              final isLoading = state.actionState.isLoading;
              return TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        final reason = _reasonController.text.trim();
                        if (reason.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'reservations.rejectReasonRequired'.tr(),
                              ),
                            ),
                          );
                          return;
                        }
                        context
                            .read<DoctorAppointmentsViewModel>()
                            .rejectAppointment(
                              id: widget.appointmentId,
                              reason: reason,
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
                        'reservations.rejectConfirm'.tr(),
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
