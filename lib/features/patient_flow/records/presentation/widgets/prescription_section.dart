import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PrescriptionSection extends StatelessWidget {
  final String title;
  final Widget child;

  const PrescriptionSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.regular14.copyWith(color: theme.textColor200),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
