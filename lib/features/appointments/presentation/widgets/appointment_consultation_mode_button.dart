import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class AppointmentConsultationModeButton extends StatelessWidget {
  final String mode;
  final bool enabled;
  final bool loading;
  final VoidCallback onPressed;

  const AppointmentConsultationModeButton({
    super.key,
    required this.mode,
    required this.enabled,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final foreground = theme.whiteColor;

    return SizedBox(
      height: 72,
      child: ElevatedButton(
        onPressed: enabled && !loading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: theme.primaryColor,
          disabledBackgroundColor: loading
              ? theme.primaryColor
              : theme.textColor100.withValues(alpha: 0.35),
          foregroundColor: foreground,
          disabledForegroundColor: theme.textColor300,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: loading
            ? SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.whiteColor,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _icon,
                    size: 20,
                    color: enabled ? theme.whiteColor : theme.textColor300,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.medium13.copyWith(
                      color: enabled ? theme.whiteColor : theme.textColor300,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  IconData get _icon {
    switch (mode) {
      case 'CHAT':
        return Icons.chat_bubble_outline;
      case 'VOICE':
        return Icons.call;
      default:
        return Icons.videocam_outlined;
    }
  }

  String get _label {
    switch (mode) {
      case 'CHAT':
        return 'home.doctorDetails.consultationChat'.tr();
      case 'VOICE':
        return 'home.doctorDetails.consultationCall'.tr();
      default:
        return 'home.doctorDetails.consultationVideo'.tr();
    }
  }
}
