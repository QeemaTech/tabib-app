import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class DoctorHeaderCard extends StatelessWidget {
  const DoctorHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomImageView(
            imagePath: AssetsManager.doctor,
            height: 80,
            width: 80,
            radius: BorderRadius.circular(40),
          ),
          const SizedBox(height: 12),
          Text(
            'appointments.drName'.tr(),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          Text(
            'appointments.physiotherapy'.tr(),
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStat(Icons.star, '4.88 (1456 ${'home.appointmentDetails.reviews'.tr()})', const Color(0xFFFFB800), theme),
              const SizedBox(width: 12),
              _buildStat(Icons.access_time, '15 ${'home.appointmentDetails.years'.tr()}', theme.textColor300, theme),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: theme.textColor300),
              const SizedBox(width: 4),
              Text(
                'home.appointmentDetails.sampleLocation'.tr(),
                style: theme.regular12.copyWith(color: theme.textColor300),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String text, Color color, dynamic theme) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.regular12.copyWith(color: theme.textColor300),
        ),
      ],
    );
  }
}
