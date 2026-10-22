import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class NotificationStatusMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const NotificationStatusMessage({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'common.retry'.tr(),
                style: theme.medium16.copyWith(color: theme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
