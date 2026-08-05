import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class WalletHeader extends StatelessWidget {
  const WalletHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 20),
      child: Text(
        'wallet.title'.tr(),
        style: theme.bold24.copyWith(color: theme.textColor600),
      ),
    );
  }
}
