import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class SpecialtyTag extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color bgColor;

  const SpecialtyTag({
    super.key,
    required this.label,
    required this.textColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: theme.medium13.copyWith(color: textColor, fontSize: 13),
      ),
    );
  }
}
