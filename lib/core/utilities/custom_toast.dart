import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

enum ToastStatus { success, error, warning, info }

class CustomToast {
  CustomToast._();

  static void show(
    BuildContext context, {
    required String message,
    ToastStatus status = ToastStatus.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = context.appTheme;
    final config = _ToastConfig.from(status);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: duration,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: config.backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(config.icon, color: config.foregroundColor, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: theme.regular14.copyWith(
                      color: config.foregroundColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  static void success(BuildContext context, String message) =>
      show(context, message: message, status: ToastStatus.success);

  static void error(BuildContext context, String message) =>
      show(context, message: message, status: ToastStatus.error);

  static void warning(BuildContext context, String message) =>
      show(context, message: message, status: ToastStatus.warning);

  static void info(BuildContext context, String message) =>
      show(context, message: message, status: ToastStatus.info);
}

class _ToastConfig {
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  const _ToastConfig({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
  });

  factory _ToastConfig.from(ToastStatus status) {
    switch (status) {
      case ToastStatus.success:
        return const _ToastConfig(
          backgroundColor: Color(0xFFE8F5E9),
          foregroundColor: Color(0xFF2E7D32),
          icon: Icons.check_circle_rounded,
        );
      case ToastStatus.error:
        return const _ToastConfig(
          backgroundColor: Color(0xFFFFEBEE),
          foregroundColor: Color(0xFFC62828),
          icon: Icons.error_rounded,
        );
      case ToastStatus.warning:
        return const _ToastConfig(
          backgroundColor: Color(0xFFFFF8E1),
          foregroundColor: Color(0xFFF57F17),
          icon: Icons.warning_rounded,
        );
      case ToastStatus.info:
        return const _ToastConfig(
          backgroundColor: Color(0xFFE8EEF8),
          foregroundColor: Color(0xFF263B73),
          icon: Icons.info_rounded,
        );
    }
  }
}
