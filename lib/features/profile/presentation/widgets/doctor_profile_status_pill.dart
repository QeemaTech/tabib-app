import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/theme/app_theme/theme_extension.dart';

class DoctorProfileStatusPill extends StatelessWidget {
  final String status;

  const DoctorProfileStatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final color = _statusColor(theme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_statusIcon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            _verificationLabel,
            style: theme.bold12.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Color _statusColor(AppThemeExtension theme) {
    switch (status.toUpperCase()) {
      case 'VERIFIED':
      case 'APPROVED':
        return theme.primaryColor;
      case 'REJECTED':
        return theme.textColor600;
      default:
        return theme.textColor300;
    }
  }

  IconData get _statusIcon {
    switch (status.toUpperCase()) {
      case 'VERIFIED':
      case 'APPROVED':
        return Icons.verified;
      case 'REJECTED':
        return Icons.cancel_outlined;
      default:
        return Icons.hourglass_top_rounded;
    }
  }

  String get _verificationLabel {
    switch (status.toUpperCase()) {
      case 'VERIFIED':
      case 'APPROVED':
        return 'profile.doctor.statusVerified'.tr();
      case 'REJECTED':
        return 'profile.doctor.statusRejected'.tr();
      case 'PENDING':
        return 'profile.doctor.statusPending'.tr();
      default:
        return status;
    }
  }
}
