import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType,
    this.suffixWidget,
    this.padding,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.initialValue,
    this.style,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;
  final String? initialValue;
  final TextStyle? style;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          24.0,
        ), // Creates the smooth rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4), // Replicates the soft bottom shadow
          ),
        ],
      ),
      child: TextFormField(
        readOnly: readOnly,
        validator: validator,
        onTapUpOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        initialValue: initialValue,
        onTap: onTap,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        style: theme.regular14,
        decoration: InputDecoration(
          suffix: suffixWidget,
          hintText: hintText,
          hintStyle:style?? theme.regular14.copyWith(color: theme.textColor200),
          contentPadding: padding ?? const EdgeInsets.all(16.0),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
