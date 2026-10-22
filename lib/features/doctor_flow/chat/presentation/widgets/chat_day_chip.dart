import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ChatDayChip extends StatelessWidget {
  final String label;

  const ChatDayChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.textColor100.withValues(alpha: 0.6),
            ),
          ),
          child: Text(
            label,
            style: theme.regular12.copyWith(color: theme.textColor300),
          ),
        ),
      ),
    );
  }
}
