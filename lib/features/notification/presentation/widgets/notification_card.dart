import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

import '../../../../core/constant/assets_manager.dart';
import '../../../../core/utilities/custom_image_view.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRead ? theme.whiteColor : const Color(0xFFEAF8F6),
          borderRadius: BorderRadius.circular(16),
          border: isRead ? Border.all(color: theme.textColor100) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.bold18.copyWith(
                      fontSize: 16,
                      color: theme.textColor600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: theme.textColor200,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: theme.regular12.copyWith(
                          color: theme.textColor200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            CustomImageView(imagePath: AssetsManager.activeNotification),
          ],
        ),
      ),
    );
  }
}
