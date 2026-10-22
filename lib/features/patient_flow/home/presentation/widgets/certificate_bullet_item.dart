import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class CertificateBulletItem extends StatelessWidget {
  final String text;

  const CertificateBulletItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: theme.textColor300,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
        ),
      ],
    );
  }
}
