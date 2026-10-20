import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/appointments/presentation/widgets/appointment_consultation_mode_button.dart';
import 'package:tabib_app/features/calls/presentation/utils/video_call_args.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_state.dart';
import 'package:tabib_app/features/chat/presentation/view_model/start_consultation_view_model.dart';

class DoctorReservationSessionActions extends StatelessWidget {
  final String appointmentId;
  final String peerName;
  final bool canChat;
  final bool canCall;

  const DoctorReservationSessionActions({
    super.key,
    required this.appointmentId,
    required this.peerName,
    required this.canChat,
    required this.canCall,
  });

  static bool showsForStatus(String status) {
    final value = status.toUpperCase();
    return value == 'CONFIRMED' || value == 'IN_PROGRESS';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartConsultationViewModel, StartConsultationState>(
      builder: (context, startState) {
        final chatLoading = startState.startState.isLoading &&
            startState.appointmentId == appointmentId;
        return Row(
          children: [
            Expanded(
              child: AppointmentConsultationModeButton(
                mode: 'CHAT',
                loading: chatLoading,
                enabled: canChat,
                onPressed: () => context
                    .read<StartConsultationViewModel>()
                    .startChat(appointmentId),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppointmentConsultationModeButton(
                mode: 'VOICE',
                loading: false,
                enabled: canCall,
                onPressed: () => _startCall(context, 'VOICE'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppointmentConsultationModeButton(
                mode: 'VIDEO',
                loading: false,
                enabled: canCall,
                onPressed: () => _startCall(context, 'VIDEO'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _startCall(BuildContext context, String callType) {
    Navigator.of(context).pushNamed(
      AppRoutes.videoCallView,
      arguments: VideoCallArgs(
        appointmentId: appointmentId,
        callType: callType,
        peerName: peerName,
      ),
    );
  }
}
