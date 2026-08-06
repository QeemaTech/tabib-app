import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ReportFieldLabel extends StatelessWidget {
  final String label;
  const ReportFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label.tr(),
        style: context.appTheme.regular14
            .copyWith(color: context.appTheme.textColor300),
      ),
    );
  }
}

class ReportTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const ReportTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: theme.textColor100),
    );
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: theme.regular14.copyWith(color: theme.textColor600),
      decoration: InputDecoration(
        hintText: hint.tr(),
        hintStyle: theme.regular14.copyWith(color: theme.textColor200),
        filled: true,
        fillColor: theme.whiteColor,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor500),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor500),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
