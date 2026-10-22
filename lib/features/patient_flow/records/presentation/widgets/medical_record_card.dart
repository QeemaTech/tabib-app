import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class MedicalRecordCard extends StatelessWidget {
  final String badgeText;
  final String doctorName;
  final String specialty;
  final String summary;
  final String date;
  final String time;
  final VoidCallback? onDownloadTap;
  final VoidCallback? onViewTap;

  const MedicalRecordCard({
    super.key,
    required this.badgeText,
    required this.doctorName,
    required this.specialty,
    required this.summary,
    required this.date,
    required this.time,
    this.onDownloadTap,
    this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBadge(theme),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    doctorName,
                    style: theme.bold18.copyWith(color: theme.textColor600),
                  ),
                  Text(
                    specialty,
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'records.summary'.tr(),
            style: theme.medium16.copyWith(color: theme.textColor600),
          ),
          const SizedBox(height: 4),
          Text(
            summary,
            style: theme.regular14.copyWith(
              color: theme.textColor300,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$date | $time',
                  style: theme.regular12.copyWith(color: theme.textColor200),
                ),
              ),
              if (onDownloadTap != null) ...[
                _buildActionButton(
                  onTap: onDownloadTap,
                  icon: Icons.file_download_outlined,
                  label: 'records.download'.tr(),
                  theme: theme,
                ),
                const SizedBox(width: 16),
              ],
              _buildActionButton(
                onTap: onViewTap,
                icon: Icons.visibility_outlined,
                label: 'records.view'.tr(),
                theme: theme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(dynamic theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light green
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        badgeText,
        style: const TextStyle(
          color: Color(0xFF2E7D32), // Dark green
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback? onTap,
    required IconData icon,
    required String label,
    required dynamic theme,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: theme.primaryColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.medium13.copyWith(color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
