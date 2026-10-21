import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class DoctorProfileFeeChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const DoctorProfileFeeChip({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: theme.primaryColor),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.regular12.copyWith(color: theme.textColor300),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.bold12.copyWith(color: theme.textColor600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
