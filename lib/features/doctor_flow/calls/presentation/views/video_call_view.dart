import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/view_model/video_call_state.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/view_model/video_call_view_model.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/widgets/call_controls_bar.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/widgets/call_ended_sheet.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/widgets/call_peer_header.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/widgets/local_video_preview.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/widgets/remote_video_surface.dart';
import 'package:tabib_app/features/doctor_flow/calls/presentation/widgets/voice_call_avatar.dart';

class VideoCallView extends StatelessWidget {
  const VideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorVideoCallViewModel, VideoCallState>(
      listenWhen: (previous, current) =>
          previous.endedSession != current.endedSession &&
          current.endedSession != null,
      listener: (context, state) {
        final session = state.endedSession;
        if (session == null) return;
        showModalBottomSheet<void>(
          context: context,
          isDismissible: false,
          enableDrag: false,
          builder: (_) => CallEndedSheet(
            session: session,
            onDone: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        );
      },
      builder: (context, state) {
        final connect = state.connectState;
        if (connect.isLoading || connect.isInitial) {
          return const _VideoCallLoadingWidget();
        }
        if (connect.isError) {
          return _VideoCallErrorWidget(
            message: connect.errorMessage ?? 'errors.unknown'.tr(),
          );
        }
        return const _VideoCallSuccessWidget();
      },
    );
  }
}

class _VideoCallLoadingWidget extends StatelessWidget {
  const _VideoCallLoadingWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final peerName = context.select(
      (DoctorVideoCallViewModel cubit) => cubit.state.peerName,
    );
    return Scaffold(
      backgroundColor: theme.blackColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: theme.primaryColor),
            const SizedBox(height: 16),
            Text(
              peerName.isNotEmpty ? peerName : 'calls.connecting'.tr(),
              style: theme.medium16.copyWith(color: theme.whiteColor),
            ),
            const SizedBox(height: 8),
            Text(
              'calls.connecting'.tr(),
              style: theme.regular14.copyWith(color: theme.textColor100),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoCallErrorWidget extends StatelessWidget {
  final String message;

  const _VideoCallErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.textColor600, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message.tr(),
            textAlign: TextAlign.center,
            style: theme.regular16.copyWith(color: theme.textColor600),
          ),
        ),
      ),
    );
  }
}

class _VideoCallSuccessWidget extends StatelessWidget {
  const _VideoCallSuccessWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final cubit = context.read<DoctorVideoCallViewModel>();
    final engine = cubit.agoraRtcService.engine;

    return BlocBuilder<DoctorVideoCallViewModel, VideoCallState>(
      builder: (context, state) {
        final status = state.remoteUid != null
            ? 'calls.connected'.tr()
            : 'calls.waitingPeer'.tr();

        return Scaffold(
          backgroundColor: theme.blackColor,
          body: Stack(
            fit: StackFit.expand,
            children: [
              if (state.isVideo && engine != null)
                RemoteVideoSurface(
                  engine: engine,
                  remoteUid: state.remoteUid,
                  channelId: state.channelName,
                )
              else
                ColoredBox(
                  color: theme.blackColor,
                  child: Center(
                    child: VoiceCallAvatar(peerName: state.peerName),
                  ),
                ),
              CallPeerHeader(peerName: state.peerName, statusLabel: status),
              if (state.isVideo && engine != null)
                LocalVideoPreview(
                  engine: engine,
                  isCameraOff: state.isCameraOff,
                  onTap: cubit.switchCamera,
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CallControlsBar(
                  isMuted: state.isMuted,
                  isCameraOff: state.isCameraOff,
                  showCameraControls: state.isVideo,
                  isEnding: state.isEnding,
                  onToggleMute: cubit.toggleMute,
                  onToggleCamera: cubit.toggleCamera,
                  onSwitchCamera: cubit.switchCamera,
                  onEndCall: cubit.endCall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
