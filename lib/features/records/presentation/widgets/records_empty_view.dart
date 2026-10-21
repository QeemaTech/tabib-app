import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class RecordsEmptyView extends StatelessWidget {
  const RecordsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Text(
        'records.empty'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      ),
    );
  }
}
