import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/doctor_flow/calls/domain/entities/call_session_entity.dart';

class VideoCallState extends Equatable {
  final BaseState<bool> connectState;
  final String callType;
  final String peerName;
  final String channelName;
  final int? localUid;
  final int? remoteUid;
  final bool isMuted;
  final bool isCameraOff;
  final bool isEnding;
  final CallSessionEntity? endedSession;
  final String? errorMessage;

  const VideoCallState({
    this.connectState = const BaseState(requestState: RequestState.init),
    this.callType = 'VIDEO',
    this.peerName = '',
    this.channelName = '',
    this.localUid,
    this.remoteUid,
    this.isMuted = false,
    this.isCameraOff = false,
    this.isEnding = false,
    this.endedSession,
    this.errorMessage,
  });

  bool get isVideo => callType.toUpperCase() == 'VIDEO';

  VideoCallState copyWith({
    BaseState<bool>? connectState,
    String? callType,
    String? peerName,
    String? channelName,
    int? localUid,
    int? remoteUid,
    bool clearRemoteUid = false,
    bool? isMuted,
    bool? isCameraOff,
    bool? isEnding,
    CallSessionEntity? endedSession,
    String? errorMessage,
    bool clearError = false,
  }) {
    return VideoCallState(
      connectState: connectState ?? this.connectState,
      callType: callType ?? this.callType,
      peerName: peerName ?? this.peerName,
      channelName: channelName ?? this.channelName,
      localUid: localUid ?? this.localUid,
      remoteUid: clearRemoteUid ? null : (remoteUid ?? this.remoteUid),
      isMuted: isMuted ?? this.isMuted,
      isCameraOff: isCameraOff ?? this.isCameraOff,
      isEnding: isEnding ?? this.isEnding,
      endedSession: endedSession ?? this.endedSession,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        connectState,
        callType,
        peerName,
        channelName,
        localUid,
        remoteUid,
        isMuted,
        isCameraOff,
        isEnding,
        endedSession,
        errorMessage,
      ];
}
