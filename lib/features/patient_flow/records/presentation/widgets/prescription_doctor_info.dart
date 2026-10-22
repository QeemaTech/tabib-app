import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

import '../../../../../core/constant/assets_manager.dart';

class PrescriptionDoctorInfo extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String referenceLabel;
  final String rxNumber;
  final String? imageUrl;

  const PrescriptionDoctorInfo({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.referenceLabel,
    required this.rxNumber,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: imageUrl,
                height: 48,
                width: 48,
                radius: BorderRadius.circular(24),
                placeHolder: AssetsManager.doctor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: theme.bold18.copyWith(color: theme.textColor600),
                    ),
                    Text(
                      specialty,
                      style: theme.regular14.copyWith(
                        color: theme.textColor300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (date.isNotEmpty || time.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.calendar_today_outlined,
              time.isEmpty ? date : (date.isEmpty ? time : '$date | $time'),
              theme,
            ),
          ],
          if (rxNumber.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.receipt_long_outlined,
              referenceLabel.isEmpty ? rxNumber : '$referenceLabel $rxNumber',
              theme,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, dynamic theme) {
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.textColor300),
        const SizedBox(width: 8),
        Text(text, style: theme.regular12.copyWith(color: theme.textColor300)),
      ],
    );
  }
}
