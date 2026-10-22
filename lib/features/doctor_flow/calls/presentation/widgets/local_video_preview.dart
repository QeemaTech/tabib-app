import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class LocalVideoPreview extends StatelessWidget {
  final RtcEngine engine;
  final bool isCameraOff;
  final VoidCallback? onTap;

  const LocalVideoPreview({
    super.key,
    required this.engine,
    required this.isCameraOff,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 72, end: 16),
          child: GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 110,
                height: 160,
                child: isCameraOff
                    ? ColoredBox(
                        color: theme.textColor600,
                        child: Icon(
                          Icons.videocam_off,
                          color: theme.whiteColor,
                        ),
                      )
                    : AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
