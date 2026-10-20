import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

enum CallMediaMode { video, voice }

@lazySingleton
class AgoraRtcService {
  RtcEngine? _engine;
  CallMediaMode _mediaMode = CallMediaMode.video;

  void Function(int uid)? onLocalUserJoined;
  void Function(int uid)? onRemoteUserJoined;
  void Function(int uid)? onRemoteUserLeft;
  void Function(String token)? onTokenPrivilegeWillExpire;
  void Function(String message)? onError;

  RtcEngine? get engine => _engine;

  bool get isInitialized => _engine != null;

  CallMediaMode get mediaMode => _mediaMode;

  Future<void> ensurePermissions({
    required CallMediaMode mediaMode,
  }) async {
    await _require(Permission.microphone);
    if (mediaMode == CallMediaMode.video) {
      await _require(Permission.camera);
    }
  }

  Future<void> _require(Permission permission) async {
    var status = await permission.status;
    if (_isAllowed(status)) return;
    if (!status.isPermanentlyDenied) {
      status = await permission.request();
    }
    if (_isAllowed(status)) return;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    throw StateError(
      permission == Permission.camera
          ? 'Camera permission is required'
          : 'Microphone permission is required',
    );
  }

  bool _isAllowed(PermissionStatus status) =>
      status.isGranted || status.isLimited;

  Future<void> initialize({
    required String appId,
    CallMediaMode mediaMode = CallMediaMode.video,
  }) async {
    _mediaMode = mediaMode;
    final isVideo = mediaMode == CallMediaMode.video;
    await ensurePermissions(mediaMode: mediaMode);

    var engine = _engine;
    if (engine == null) {
      engine = createAgoraRtcEngine();
      try {
        await engine.initialize(
          RtcEngineContext(
            appId: appId,
            channelProfile: ChannelProfileType.channelProfileCommunication,
          ),
        );
        engine.registerEventHandler(
          RtcEngineEventHandler(
            onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
              final uid = connection.localUid;
              if (uid != null) {
                onLocalUserJoined?.call(uid);
              }
            },
            onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
              onRemoteUserJoined?.call(remoteUid);
            },
            onUserOffline: (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              onRemoteUserLeft?.call(remoteUid);
            },
            onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
              onTokenPrivilegeWillExpire?.call(token);
            },
            onError: (ErrorCodeType err, String msg) {
              onError?.call('$err: $msg');
            },
          ),
        );
        _engine = engine;
      } catch (_) {
        await engine.release();
        rethrow;
      }
    } else {
      try {
        await engine.leaveChannel();
      } catch (_) {}
    }

    await _applyMediaMode(engine, isVideo);
  }

  Future<void> _applyMediaMode(RtcEngine engine, bool isVideo) async {
    await engine.enableAudio();
    if (isVideo) {
      await engine.enableVideo();
      await engine.startPreview();
      return;
    }
    await engine.disableVideo();
  }

  Future<void> join({
    required String token,
    required String channelId,
    int uid = 0,
  }) async {
    final engine = _engine;
    if (engine == null) {
      throw StateError('AgoraRtcService is not initialized');
    }

    final isVideo = _mediaMode == CallMediaMode.video;

    await engine.joinChannel(
      token: token,
      channelId: channelId,
      uid: uid,
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
        publishCameraTrack: isVideo,
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
        autoSubscribeVideo: isVideo,
      ),
    );
  }

  Future<void> renewToken(String token) async {
    await _engine?.renewToken(token);
  }

  Future<void> muteLocalAudio(bool mute) async {
    await _engine?.muteLocalAudioStream(mute);
  }

  Future<void> enableLocalVideo(bool enable) async {
    await _engine?.enableLocalVideo(enable);
  }

  Future<void> switchCamera() async {
    if (_mediaMode != CallMediaMode.video) return;
    await _engine?.switchCamera();
  }

  Future<void> leave() async {
    await _engine?.leaveChannel();
  }

  void clearCallbacks() {
    onLocalUserJoined = null;
    onRemoteUserJoined = null;
    onRemoteUserLeft = null;
    onTokenPrivilegeWillExpire = null;
    onError = null;
  }

  Future<void> dispose() async {
    await leave();
    await _engine?.release();
    _engine = null;
    clearCallbacks();
  }
}
