import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/doctor_dashboard_view_model.dart';
import 'package:tabib_app/features/profile/presentation/widgets/doc_stat_card.dart';

class DocProfileStatsRow extends StatelessWidget {
  const DocProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDashboardViewModel, DoctorDashboardState>(
      buildWhen: (previous, current) =>
          previous.dashboardState != current.dashboardState,
      builder: (context, state) {
        final stats = state.dashboardState.data?.stats;
        final earnings = stats?.earnings;
        final patients = stats?.totalCompletedCount;
        final rating = stats?.rating;
        final hasRating = rating != null && rating > 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: DocStatCard(
                  title: 'profile.doctor.earnings'.tr(),
                  value: earnings != null ? _formatNumber(earnings) : '0',
                  icon: AssetsManager.moneys,
                  valueColor: context.appTheme.primaryColor,
                  prefixValue: '${'common.currency'.tr()} ',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DocStatCard(
                  title: 'profile.doctor.patients'.tr(),
                  value: patients != null ? '$patients' : '0',
                  icon: AssetsManager.profile,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DocStatCard(
                  title: 'profile.doctor.ratings'.tr(),
                  value: hasRating ? rating.toStringAsFixed(1) : '0',
                  icon: AssetsManager.edit,
                  showStars: hasRating,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatNumber(num value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }
}
