import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/agora_rtc_service.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/calls/domain/entities/agora_token_entity.dart';
import 'package:tabib_app/features/calls/domain/entities/call_session_entity.dart';
import 'package:tabib_app/features/calls/domain/repo/calls_repo.dart';
import 'package:tabib_app/features/calls/presentation/view_model/video_call_state.dart';
import 'package:tabib_app/features/chat/domain/entities/started_consultation_entity.dart';

@injectable
class VideoCallViewModel extends Cubit<VideoCallState> {
  VideoCallViewModel({
    required this.callsRepo,
    required this.agoraRtcService,
  }) : super(const VideoCallState());

  final CallsRepo callsRepo;
  final AgoraRtcService agoraRtcService;

  String? _callId;
  String? _channelName;
  bool _ended = false;

  void _bindCallbacks() {
    agoraRtcService.onLocalUserJoined = (uid) {
      if (!isClosed) emit(state.copyWith(localUid: uid));
    };
    agoraRtcService.onRemoteUserJoined = (uid) {
      if (!isClosed) emit(state.copyWith(remoteUid: uid));
    };
    agoraRtcService.onRemoteUserLeft = (_) {
      if (!isClosed) emit(state.copyWith(clearRemoteUid: true));
    };
    agoraRtcService.onTokenPrivilegeWillExpire = (_) => _renewToken();
    agoraRtcService.onError = (message) {
      if (!isClosed) emit(state.copyWith(errorMessage: message));
    };
  }

  Future<void> startCall({
    required String appointmentId,
    required String callType,
    String peerName = '',
  }) async {
    if (state.connectState.isLoading) return;

    final type = 'CHAT';
    emit(
      state.copyWith(
        callType: type,
        peerName: peerName,
        connectState: BaseState.loading(),
        clearError: true,
        isCameraOff: type != 'VIDEO',
      ),
    );

    final startResult = await callsRepo.startConsultation(
      appointmentId: appointmentId,
      type: type,
    );
    if (startResult case Failure<StartedConsultationEntity>()) {
      emit(state.copyWith(connectState: BaseState.error(startResult.errorMessage)));
      return;
    }

    final consultation = (startResult as Success<StartedConsultationEntity>).data;
    final callId = consultation.videoCallId;
    final roomId = consultation.videoRoomId;
    if (callId == null || callId.isEmpty || roomId == null || roomId.isEmpty) {
      emit(state.copyWith(connectState: BaseState.error('calls.missingRoom')));
      return;
    }

    _callId = callId;
    _channelName = roomId;

    final tokenResult = await callsRepo.getAgoraToken(channelName: roomId);
    if (tokenResult case Failure<AgoraTokenEntity>()) {
      emit(state.copyWith(connectState: BaseState.error(tokenResult.errorMessage)));
      return;
    }

    final tokenData = (tokenResult as Success<AgoraTokenEntity>).data;
    if (tokenData.token.isEmpty ||
        tokenData.appId.isEmpty ||
        tokenData.channelName.isEmpty) {
      emit(state.copyWith(connectState: BaseState.error('calls.invalidToken')));
      return;
    }

    _channelName = tokenData.channelName;
    _bindCallbacks();

    try {
      await agoraRtcService.initialize(
        appId: tokenData.appId,
        mediaMode: type == 'VOICE' ? CallMediaMode.voice : CallMediaMode.video,
      );
      await agoraRtcService.join(
        token: tokenData.token,
        channelId: tokenData.channelName,
      );
      if (!isClosed) {
        emit(
          state.copyWith(
            connectState: BaseState.loaded(true),
            channelName: tokenData.channelName,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(connectState: BaseState.error(e.toString())));
      }
    }
  }

  Future<void> _renewToken() async {
    final channel = _channelName;
    if (channel == null || channel.isEmpty) return;
    final result = await callsRepo.getAgoraToken(channelName: channel);
    if (result case Success<AgoraTokenEntity>()) {
      await agoraRtcService.renewToken(result.data.token);
    }
  }

  Future<void> toggleMute() async {
    final next = !state.isMuted;
    await agoraRtcService.muteLocalAudio(next);
    emit(state.copyWith(isMuted: next));
  }

  Future<void> toggleCamera() async {
    if (!state.isVideo) return;
    final next = !state.isCameraOff;
    await agoraRtcService.enableLocalVideo(!next);
    emit(state.copyWith(isCameraOff: next));
  }

  Future<void> switchCamera() async {
    if (!state.isVideo || state.isCameraOff) return;
    await agoraRtcService.switchCamera();
  }

  Future<void> endCall() async {
    if (_ended || state.isEnding) return;
    emit(state.copyWith(isEnding: true, clearError: true));
    await agoraRtcService.dispose();

    final callId = _callId;
    CallSessionEntity session = CallSessionEntity(
      id: callId ?? '',
      appointmentId: '',
      channelName: _channelName ?? '',
      callType: state.callType,
      status: 'ENDED',
      startedAt: '',
      durationSeconds: 0,
    );
    String? error;
    if (callId != null && callId.isNotEmpty) {
      final result = await callsRepo.endCall(callId: callId);
      if (result case Success<CallSessionEntity>()) session = result.data;
      if (result case Failure<CallSessionEntity>()) error = result.errorMessage;
    }

    _ended = true;
    if (!isClosed) {
      emit(state.copyWith(isEnding: false, endedSession: session, errorMessage: error));
    }
  }

  @override
  Future<void> close() async {
    if (!_ended) {
      await agoraRtcService.dispose();
      final callId = _callId;
      if (callId != null && callId.isNotEmpty) {
        await callsRepo.endCall(callId: callId);
      }
      _ended = true;
    } else {
      agoraRtcService.clearCallbacks();
    }
    return super.close();
  }
}
