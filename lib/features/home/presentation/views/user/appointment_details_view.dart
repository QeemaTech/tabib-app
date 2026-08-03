import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/theme/app_theme/theme_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

import '../../../../../core/routes/routes.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text('home.appointmentDetails.title'.tr(), style: theme.bold18),
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Doctor Info Card
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.doctorDetailsView);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x33C6BBCA),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                        spreadRadius: 0,
                      )
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
                          _buildDoctorStat(
                            Icons.star,
                            '4.88 (1456 ${'home.appointmentDetails.reviews'.tr()})',
                            theme,
                            iconColor: const Color(0xFFFFB800),
                          ),
                          const SizedBox(width: 12),
                          _buildDoctorStat(
                            Icons.access_time,
                            '15 ${'home.appointmentDetails.years'.tr()}',
                            theme,
                            iconColor: theme.textColor300,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: theme.textColor300,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'home.appointmentDetails.sampleLocation'.tr(),
                            style: theme.regular12.copyWith(
                              color: theme.textColor300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Details List
              _buildDetailItem(
                'home.appointmentDetails.day'.tr(),
                'home.appointmentDetails.sampleDay'.tr(),
                theme,
              ),
              const SizedBox(height: 12),
              _buildDetailItem(
                'home.appointmentDetails.time'.tr(),
                'home.appointmentDetails.sampleTime'.tr(),
                theme,
              ),
              const SizedBox(height: 12),
              _buildDetailItem(
                'home.appointmentDetails.price'.tr(),
                '500 ${'home.search.currency'.tr()}',
                theme,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all( 16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F7DC9A3),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'home.appointmentDetails.cancel'.tr(),
                  style: theme.medium16.copyWith(color: theme.textColor300),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'home.appointmentDetails.start'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorStat(
    IconData icon,
    String text,
    dynamic theme, {
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text(text, style: theme.regular12.copyWith(color: theme.textColor300)),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, AppThemeExtension theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.regular14.copyWith(
              fontSize: 16.0,
              color: theme.textColor300,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.bold18.copyWith(
              fontSize: 16.0,
              color: theme.primaryColor500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
