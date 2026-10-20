import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class CallControlsBar extends StatelessWidget {
  final bool isMuted;
  final bool isCameraOff;
  final bool showCameraControls;
  final bool isEnding;
  final VoidCallback onToggleMute;
  final VoidCallback? onToggleCamera;
  final VoidCallback? onSwitchCamera;
  final VoidCallback onEndCall;

  const CallControlsBar({
    super.key,
    required this.isMuted,
    required this.isCameraOff,
    required this.showCameraControls,
    required this.isEnding,
    required this.onToggleMute,
    this.onToggleCamera,
    this.onSwitchCamera,
    required this.onEndCall,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ControlButton(
              icon: isMuted ? Icons.mic_off : Icons.mic,
              background: theme.textColor300,
              onTap: onToggleMute,
            ),
            if (showCameraControls) ...[
              _ControlButton(
                icon: isCameraOff ? Icons.videocam_off : Icons.videocam,
                background: theme.textColor300,
                onTap: onToggleCamera,
              ),
              _ControlButton(
                icon: Icons.cameraswitch,
                background: theme.textColor300,
                onTap: isCameraOff ? null : onSwitchCamera,
              ),
            ],
            _ControlButton(
              icon: Icons.call_end,
              background: theme.primaryColor,
              onTap: isEnding ? null : onEndCall,
              isLoading: isEnding,
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final Color background;
  final VoidCallback? onTap;
  final bool isLoading;

  const _ControlButton({
    required this.icon,
    required this.background,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.whiteColor,
                    ),
                  )
                : Icon(icon, color: theme.whiteColor),
          ),
        ),
      ),
    );
  }
}
