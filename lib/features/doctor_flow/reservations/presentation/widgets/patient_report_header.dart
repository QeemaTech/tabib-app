import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class PatientReportHeader extends StatelessWidget {
  final String name;
  final String id;
  final String date;
  final String time;
  final String? image;

  const PatientReportHeader({
    super.key,
    required this.name,
    required this.id,
    required this.date,
    required this.time,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100),
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: (image != null && image!.trim().isNotEmpty)
                ? image
                : AssetsManager.doctor,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(12),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bold18
                      .copyWith(fontSize: 16, color: theme.textColor600),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: #$id',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date • $time',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.regular12.copyWith(color: theme.textColor300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
