import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/schedule/presentation/utils/schedule_display.dart';
import 'package:tabib_app/features/schedule/presentation/view_model/doctor_schedule_state.dart';
import 'package:tabib_app/features/schedule/presentation/view_model/doctor_schedule_view_model.dart';
import 'package:tabib_app/features/schedule/presentation/widgets/schedule_day_card.dart';
import 'package:tabib_app/features/schedule/presentation/widgets/schedule_preview_section.dart';
import 'package:tabib_app/features/schedule/presentation/widgets/show_schedule_edit_day_sheet.dart';

class DoctorScheduleView extends StatelessWidget {
  const DoctorScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isAr = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            isAr ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: Text(
          'schedule.title'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
      ),
      body: BlocBuilder<DoctorScheduleViewModel, DoctorScheduleState>(
        buildWhen: (p, c) => p.scheduleState != c.scheduleState,
        builder: (context, state) {
          final scheduleState = state.scheduleState;
          if (scheduleState.isLoading || scheduleState.isInitial) {
            return const _DoctorScheduleLoadingWidget();
          }
          if (scheduleState.isError) {
            return _DoctorScheduleErrorWidget(
              message: scheduleState.errorMessage ?? '',
            );
          }
          return _DoctorScheduleSuccessWidget(
            days: scheduleState.data ?? const [],
          );
        },
      ),
    );
  }
}

class _DoctorScheduleLoadingWidget extends StatelessWidget {
  const _DoctorScheduleLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 7,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, index) => ScheduleDayCard(
          dayOfWeek: index,
          day: null,
          onTap: () {},
        ),
      ),
    );
  }
}

class _DoctorScheduleErrorWidget extends StatelessWidget {
  final String message;

  const _DoctorScheduleErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.isEmpty ? 'errors.unknown'.tr() : message,
              textAlign: TextAlign.center,
              style: theme.regular14.copyWith(color: theme.textColor300),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              onPressed: () =>
                  context.read<DoctorScheduleViewModel>().retry(),
              child: Text(
                'common.retry'.tr(),
                style: theme.regular14.copyWith(color: theme.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorScheduleSuccessWidget extends StatelessWidget {
  final List<ScheduleDayEntity> days;

  const _DoctorScheduleSuccessWidget({required this.days});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<DoctorScheduleViewModel>().loadSchedule(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'schedule.weekTitle'.tr(),
            style: context.appTheme.bold18.copyWith(
              fontSize: 16,
              color: context.appTheme.textColor600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'schedule.weekHint'.tr(),
            style: context.appTheme.regular14.copyWith(
              color: context.appTheme.textColor200,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(7, (dayOfWeek) {
            final day = ScheduleDisplay.findDay(days, dayOfWeek);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ScheduleDayCard(
                dayOfWeek: dayOfWeek,
                day: day,
                onTap: () {
                  showScheduleEditDaySheet(
                    context: context,
                    dayOfWeek: dayOfWeek,
                    isActive: day?.isActive ?? false,
                    slots: day?.slots ?? const [],
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 8),
          const SchedulePreviewSection(),
        ],
      ),
    );
  }
}
