import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/auth/presentation/widgets/lang_select.dart';

class ProfileLanguageSection extends StatelessWidget {
  const ProfileLanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'profile.language'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
        const SizedBox(height: 4),
        Text(
          'profile.languageSubtitle'.tr(),
          style: theme.regular12.copyWith(color: theme.textColor200),
        ),
        const SizedBox(height: 12),
        const LanguageSelector(),
      ],
    );
  }
}
