import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PatientProfileDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const PatientProfileDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  label,
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value.isEmpty ? '-' : value,
                  textAlign: TextAlign.end,
                  style: theme.medium16.copyWith(color: theme.textColor600),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: theme.textColor100.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
