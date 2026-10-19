import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: const Color(0xFFE9EBF1)),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33C6BBCA),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x05FFFFFF),
            blurRadius: 0,
            offset: Offset(0, -1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          splashColor: theme.primaryColor.withValues(alpha: 0.08),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Icon(icon, color: theme.primaryColor, size: 28),
          title: Text(
            title,
            style: theme.bold18.copyWith(
              fontSize: 16,
              color: theme.primaryColor500,
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle!,
                  style: theme.regular12.copyWith(color: theme.textColor200),
                ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: theme.primaryColor300,
          ),
        ),
      ),
    );
  }
}
