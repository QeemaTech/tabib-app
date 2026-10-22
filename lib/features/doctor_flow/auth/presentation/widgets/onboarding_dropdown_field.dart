import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class OnboardingDropdownField extends StatelessWidget {
  final String hintText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onChanged;
  final bool enabled;

  const OnboardingDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final selectedValue =
        items.any((item) => item.value == value) ? value : null;

    return Container(
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.06),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        hint: Text(
          hintText,
          style: theme.medium16.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.textColor300,
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.textColor300,
            size: 26,
          ),
        ),
        isExpanded: true,
        style: theme.regular14.copyWith(color: theme.textColor600),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        items: items,
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
