import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class DoctorProfileMetaChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final double iconSize;

  const DoctorProfileMetaChip({
    super.key,
    required this.label,
    required this.icon,
    this.iconSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: theme.primaryColor),
          const SizedBox(width: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.bold12.copyWith(color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
