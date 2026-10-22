import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/doctor_flow/home/domain/entities/doctor_dashboard_stats_entity.dart';
import '../../../../../core/constant/assets_manager.dart';
import '../../../../../core/extension/app_extension.dart';

class DocDashboard extends StatelessWidget {
  final DoctorDashboardStatsEntity stats;

  const DocDashboard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      children: [
        Row(
          spacing: 6,
          children: [
            Expanded(
              child: DashboardCard(
                title: "home.doctor.appointmentsToday".tr(),
                value: '${stats.todayCount}',
                icon: AssetsManager.appointmentsActive,
                iconBackgroundColor: const Color(0xFFE9EBF1),
              ),
            ),
            Expanded(
              child: DashboardCard(
                title: "home.doctor.pendingRequests".tr(),
                value: '${stats.pendingCount}',
                icon: AssetsManager.security,
                iconBackgroundColor: const Color(0xFFFEF9F0),
              ),
            ),
          ],
        ),
        Row(
          spacing: 6,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DashboardCard(
                title: "home.doctor.completeConsultations".tr(),
                value: '${stats.completedCount}',
                icon: AssetsManager.tickCircle,
                iconBackgroundColor: const Color(0xFFEAF8F6),
              ),
            ),
            Expanded(
              child: DashboardCard(
                title: "home.doctor.profitsToday".tr(),
                value: stats.earnings == stats.earnings.roundToDouble()
                    ? '${stats.earnings.toInt()}'
                    : '${stats.earnings}',
                icon: AssetsManager.emptyWallet,
                iconBackgroundColor: const Color(0xFFE4FFEB),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final Color iconBackgroundColor;
  final Color valueColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackgroundColor,
    this.valueColor = const Color(0xFF1E3A8A),
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
               Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomImageView(imagePath: icon),
              ),
              SizedBox(width: 12),
                            
              Expanded(
                child: Text(
                  title,
                  style: theme.bold24.copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

             
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: theme.bold24.copyWith(fontSize: 28, color: valueColor),
            ),
          ),
        ],
      ),
    );
  }
}
