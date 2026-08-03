import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class DoctorHeaderStat extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const DoctorHeaderStat({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.regular12.copyWith(color: theme.textColor300),
        ),
      ],
    );
  }
}
