import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class MedicalNoteCard extends StatelessWidget {
  final String note;
  final String date;

  const MedicalNoteCard({
    super.key,
    required this.note,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9EE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE0A3).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            note,
            textAlign: TextAlign.end,
            style: theme.medium16.copyWith(
              color: theme.textColor600,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: theme.regular12.copyWith(color: theme.textColor300),
          ),
        ],
      ),
    );
  }
}
