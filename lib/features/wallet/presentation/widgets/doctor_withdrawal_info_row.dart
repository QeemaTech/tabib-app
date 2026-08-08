import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class DoctorWithdrawalInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const DoctorWithdrawalInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
              value,
              style: theme.medium16.copyWith(color: theme.textColor600),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
