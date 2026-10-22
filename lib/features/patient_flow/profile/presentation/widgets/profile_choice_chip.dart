import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ProfileChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ProfileChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Material(
      color: selected
          ? theme.primaryColor.withValues(alpha: 0.12)
          : theme.whiteColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? theme.primaryColor : theme.textColor100,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.medium16.copyWith(
              color: selected ? theme.primaryColor : theme.textColor300,
            ),
          ),
        ),
      ),
    );
  }
}
