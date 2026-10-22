import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/theme/app_theme/theme_extension.dart';
import 'package:tabib_app/features/doctor_flow/wallet/presentation/utils/wallet_labels.dart';

class WalletStatusChip extends StatelessWidget {
  final String status;

  const WalletStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final colors = _colors(theme);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.$1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        WalletLabels.withdrawalStatus(status),
        style: theme.regular12.copyWith(color: colors.$2),
      ),
    );
  }

  (Color, Color) _colors(AppThemeExtension theme) {
    return switch (status) {
      'COMPLETED' => (
          theme.primaryColor.withValues(alpha: 0.12),
          theme.primaryColor,
        ),
      'REJECTED' || 'FAILED' || 'CANCELLED' => (
          theme.textColor100.withValues(alpha: 0.35),
          theme.textColor300,
        ),
      'PROCESSING' || 'APPROVED' => (
          theme.primaryColor300.withValues(alpha: 0.18),
          theme.primaryColor300,
        ),
      _ => (
          theme.textColor100.withValues(alpha: 0.25),
          theme.textColor300,
        ),
    };
  }
}
