import 'package:flutter/material.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/widgets/allergy_radio_option.dart';

class CustomRadioGroup extends StatelessWidget {
  const CustomRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AllergyRadioOption(
          title: 'common.yes',
          optionValue: true,
          groupValue: value,
          onChanged: onChanged,
        ),
        const SizedBox(width: 100),
        AllergyRadioOption(
          title: 'common.no',
          optionValue: false,
          groupValue: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
