import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PaymentAmountRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasize;

  const PaymentAmountRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final style = emphasize
        ? theme.medium16.copyWith(color: theme.primaryColor)
        : theme.regular14.copyWith(color: theme.textColor300);

    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        const SizedBox(width: 12),
        Flexible(
          child: Text(value, textAlign: TextAlign.end, style: style),
        ),
      ],
    );
  }
}
