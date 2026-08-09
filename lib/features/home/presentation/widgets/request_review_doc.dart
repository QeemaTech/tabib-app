import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/home/presentation/widgets/accepts_doctor_reviews.dart';

class RequestReviewDocCard extends StatelessWidget {
  final String patientName;
  final String subtitle;
  final String timeLabel;
  final String? imageUrl;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final bool isActionLoading;

  const RequestReviewDocCard({
    super.key,
    required this.patientName,
    required this.subtitle,
    required this.timeLabel,
    this.imageUrl,
    this.onAccept,
    this.onReject,
    this.isActionLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: theme.whiteColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: theme.textColor100),
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: [
          BoxShadow(
            color: theme.textColor100.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: (imageUrl != null && imageUrl!.trim().isNotEmpty)
                    ? imageUrl
                    : AssetsManager.user,
                height: 56,
                width: 56,
                radius: BorderRadius.circular(28),
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: theme.bold18.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.bold12.copyWith(
                        color: theme.textColor300,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: theme.textColor300,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            timeLabel,
                            style: theme.bold12.copyWith(
                              color: theme.textColor300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AcceptDoctorBtn(
            onAccept: onAccept,
            onReject: onReject,
            isLoading: isActionLoading,
          ),
        ],
      ),
    );
  }
}
