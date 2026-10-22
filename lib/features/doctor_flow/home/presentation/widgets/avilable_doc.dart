import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extension/app_extension.dart';

class AvailableDoc extends StatelessWidget {
  const AvailableDoc({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: ShapeDecoration(
        color: const Color(0xFFECF9F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        "common.availableNow".tr(),
        textAlign: TextAlign.right,
        style: theme.bold12.copyWith(
          fontSize: 10,
          color: const Color(0xFF339957),
        ),
      ),
    );
  }
}
