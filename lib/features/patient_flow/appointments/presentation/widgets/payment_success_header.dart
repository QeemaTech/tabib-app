import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class PaymentSuccessHeader extends StatelessWidget {
  const PaymentSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      children: [
        Icon(Icons.check_circle, size: 72, color: theme.primaryColor),
        const SizedBox(height: 16),
        Text(
          'appointments.paySuccess'.tr(),
          textAlign: TextAlign.center,
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
      ],
    );
  }
}
