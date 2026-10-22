import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class AppointmentCardAction extends StatelessWidget {
  final String label;
  final Color foreground;
  final Color background;
  final Color? borderColor;
  final VoidCallback? onTap;

  const AppointmentCardAction({
    super.key,
    required this.label,
    required this.foreground,
    required this.background,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor ?? background),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: theme.bold12.copyWith(color: foreground),
        ),
      ),
    );
  }
}
