import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class DetailsSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? titleTrailing;

  const DetailsSection({
    super.key,
    required this.title,
    required this.child,
    this.titleTrailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.bold18.copyWith(fontSize: 16, color: theme.textColor100),
              ),
              if (titleTrailing != null) titleTrailing!,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
