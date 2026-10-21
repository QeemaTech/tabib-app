import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/records/presentation/view_model/records_view_model.dart';

class RecordsErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const RecordsErrorView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed:
                  onRetry ?? () => context.read<RecordsViewModel>().load(),
              child: Text(
                'records.retry'.tr(),
                style: theme.medium16.copyWith(color: theme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
