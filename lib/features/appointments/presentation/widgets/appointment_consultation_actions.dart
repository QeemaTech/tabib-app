import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_appointment_details_entity.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_consultation_mode_button.dart';
import 'package:tabib_app/features/calls/presentation/utils/video_call_args.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_state.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_view_model.dart';

class AppointmentConsultationActions extends StatelessWidget {
  final PatientAppointmentDetailsEntity details;

  const AppointmentConsultationActions({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final modes = details.doctor.offeredChannels;

    return BlocBuilder<StartConsultationViewModel, StartConsultationState>(
      builder: (context, startState) {
        final chatLoading = startState.startState.isLoading;
        return Row(
          children: [
            for (var index = 0; index < modes.length; index++) ...[
              if (index > 0) const SizedBox(width: 8),
              Expanded(
                child: AppointmentConsultationModeButton(
                  mode: modes[index],
                  loading: modes[index] == 'CHAT' && chatLoading,
                  enabled: _isEnabled(modes[index]),
                  onPressed: () => _onPressed(context, modes[index]),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  bool _isEnabled(String mode) {
    if (mode == 'CHAT') return details.actions.canAccessChat;
    return details.actions.canAccessCall;
  }

  void _onPressed(BuildContext context, String mode) {
    if (mode == 'CHAT') {
      context.read<StartConsultationViewModel>().startChat(details.id);
      return;
    }
    Navigator.of(context).pushNamed(
      AppRoutes.videoCallView,
      arguments: VideoCallArgs(
        appointmentId: details.id,
        callType: mode,
        peerName: details.doctor.localizedName(context.locale.languageCode),
      ),
    );
  }
}
