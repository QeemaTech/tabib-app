import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class DoctorSearchCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final String appointmentsCount;
  final List<String> specializations;
  final String date;
  final String time;
  final String price;
  final String? imageUrl;
  final VoidCallback? onTap;

  const DoctorSearchCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.appointmentsCount,
    required this.specializations,
    required this.date,
    required this.time,
    required this.price,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: imageUrl ?? AssetsManager.doctor,
                  height: 64,
                  width: 64,
                  radius: BorderRadius.circular(32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: theme.bold18.copyWith(color: theme.textColor600),
                      ),
                      Text(
                        specialty,
                        style: theme.regular14.copyWith(color: theme.textColor300),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFFB800), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: theme.bold12.copyWith(color: theme.textColor300),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildAppointmentsBadge(theme),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'home.search.specializations'.tr(),
              style: theme.regular12.copyWith(color: theme.textColor200),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: specializations.map((spec) => _buildSpecializationChip(spec, theme)).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 16, color: theme.textColor300),
                const SizedBox(width: 8),
                Text(
                  '$date | $time',
                  style: theme.regular12.copyWith(color: theme.textColor300),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CustomImageView(
                  imagePath: AssetsManager.moneys,
                  height: 16,
                  width: 16,
                  color: theme.textColor300,
                ),
                const SizedBox(width: 8),
                Text(
                  '$price ${'home.search.currency'.tr()}',
                  style: theme.regular12.copyWith(color: theme.textColor300,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsBadge(dynamic theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.video_camera_back_outlined, size: 14, color: Color(0xFF626A7D)),
          const SizedBox(width: 4),
          Text(
            '$appointmentsCount ${'home.search.appointments'.tr()}',
            style: theme.regular12.copyWith(fontSize: 10.0, color: const Color(0xFF626A7D)),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializationChip(String text, dynamic theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF0F7),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: theme.medium13.copyWith(fontSize: 12.0, color: theme.primaryColor),
      ),
    );
  }
}
