import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ProfileLabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const ProfileLabeledField({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.medium16.copyWith(color: theme.textColor600),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
