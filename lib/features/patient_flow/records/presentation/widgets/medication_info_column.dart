import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class MedicationInfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const MedicationInfoColumn({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.regular12.copyWith(color: theme.textColor200)),
        const SizedBox(height: 2),
        Text(value, style: theme.medium13.copyWith(color: theme.textColor600)),
      ],
    );
  }
}
