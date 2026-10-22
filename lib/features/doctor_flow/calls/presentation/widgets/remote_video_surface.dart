import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class RemoteVideoSurface extends StatelessWidget {
  final RtcEngine engine;
  final int? remoteUid;
  final String channelId;

  const RemoteVideoSurface({
    super.key,
    required this.engine,
    required this.remoteUid,
    required this.channelId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    if (remoteUid == null) {
      return ColoredBox(
        color: theme.blackColor,
        child: Center(
          child: Icon(
            Icons.person,
            size: 96,
            color: theme.textColor300,
          ),
        ),
      );
    }

    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine,
        canvas: VideoCanvas(uid: remoteUid),
        connection: RtcConnection(channelId: channelId),
      ),
    );
  }
}
