import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/doctor_flow/profile/presentation/widgets/star_review.dart';

class DocStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final Color? valueColor;
  final String? prefixValue;
  final bool showStars;
  final double rating;

  const DocStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.valueColor,
    this.prefixValue,
    this.showStars = false,
    this.rating = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final color = valueColor ?? theme.primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 36,
            width: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: CustomImageView(
              imagePath: icon,
              height: 18,
              width: 18,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.regular12.copyWith(color: theme.textColor300),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixValue != null)
                  Text(
                    prefixValue!,
                    style: theme.bold18.copyWith(color: color),
                  ),
                Text(
                  value,
                  style: theme.bold18.copyWith(color: color),
                ),
              ],
            ),
          ),
          if (showStars) ...[
            const SizedBox(height: 4),
            StarReview(rating: rating),
          ],
        ],
      ),
    );
  }
}
