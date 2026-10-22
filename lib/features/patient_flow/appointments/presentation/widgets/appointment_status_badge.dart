import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/theme/app_theme/theme_extension.dart';

class AppointmentStatusBadge extends StatelessWidget {
  final String status;
  final String label;

  const AppointmentStatusBadge({
    super.key,
    required this.status,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final colors = appointmentStatusColors(theme, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: theme.bold12.copyWith(color: colors.foreground),
      ),
    );
  }
}

({Color foreground, Color background}) appointmentStatusColors(
  AppThemeExtension theme,
  String status,
) {
  switch (status.toUpperCase()) {
    case 'CANCELLED':
      return (
        foreground: theme.textColor600,
        background: theme.textColor100.withValues(alpha: 0.35),
      );
    case 'COMPLETED':
      return (
        foreground: theme.textColor300,
        background: theme.textColor100.withValues(alpha: 0.25),
      );
    case 'PENDING':
      return (
        foreground: theme.primaryColor300,
        background: theme.primaryColor300.withValues(alpha: 0.16),
      );
    default:
      return (
        foreground: theme.primaryColor,
        background: theme.primaryColor.withValues(alpha: 0.1),
      );
  }
}
