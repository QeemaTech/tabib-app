import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';

class PaymentPayerAccountField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const PaymentPayerAccountField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'appointments.payerAccount'.tr(),
          style: theme.medium13.copyWith(color: theme.textColor300),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: controller,
          hintText: 'appointments.payerAccountHint'.tr(),
          keyboardType: TextInputType.phone,
          onChanged: onChanged,
          style: theme.regular14.copyWith(color: theme.textColor200),
        ),
      ],
    );
  }
}
