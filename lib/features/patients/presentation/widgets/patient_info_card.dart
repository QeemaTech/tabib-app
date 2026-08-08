import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class PatientInfoCard extends StatelessWidget {
  final String name;
  final String id;
  final String? imagePath;

  const PatientInfoCard({
    super.key,
    required this.name,
    required this.id,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.textColor100.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: imagePath ?? AssetsManager.user,
            height: 60,
            width: 60,
            radius: BorderRadius.circular(30),
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
                  style: theme.bold18.copyWith(color: theme.textColor600),
                ),
                const SizedBox(height: 4),
                Text(
                  "${'patients.details.id'.tr()}: #$id",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.regular14.copyWith(color: theme.textColor300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
