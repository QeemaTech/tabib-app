import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class AppointmentCardFactRow extends StatelessWidget {
  final String label;
  final String value;

  const AppointmentCardFactRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final labelStyle = theme.regular12.copyWith(color: theme.textColor200);
    final valueStyle = theme.regular14.copyWith(color: theme.textColor600);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 96,
          child: Text(label, style: labelStyle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: valueStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
