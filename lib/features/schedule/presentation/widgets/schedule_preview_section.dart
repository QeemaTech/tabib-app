import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/schedule/presentation/view_model/doctor_schedule_state.dart';
import 'package:tabib_app/features/schedule/presentation/view_model/doctor_schedule_view_model.dart';

class SchedulePreviewSection extends StatelessWidget {
  const SchedulePreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocBuilder<DoctorScheduleViewModel, DoctorScheduleState>(
      buildWhen: (p, c) =>
          p.previewState != c.previewState || p.previewDate != c.previewDate,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'schedule.previewTitle'.tr(),
                style: theme.bold18.copyWith(
                  fontSize: 16,
                  color: theme.textColor600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'schedule.previewHint'.tr(),
                style: theme.regular14.copyWith(color: theme.textColor200),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () => _pickDate(context, state.previewDate),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('yyyy-MM-dd').format(state.previewDate),
                        style: theme.regular14.copyWith(
                          color: theme.textColor600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'schedule.previewLoad'.tr(),
                        style: theme.bold12.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _PreviewBody(state: state),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDate(BuildContext context, DateTime current) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null || !context.mounted) return;
    context.read<DoctorScheduleViewModel>().onPreviewDateSelected(picked);
    await context.read<DoctorScheduleViewModel>().loadPreview();
  }
}

class _PreviewBody extends StatelessWidget {
  final DoctorScheduleState state;

  const _PreviewBody({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final previewState = state.previewState;

    if (previewState.isInitial) {
      return Text(
        'schedule.previewEmptyHint'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor200),
      );
    }
    if (previewState.isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: CircularProgressIndicator(color: theme.primaryColor),
        ),
      );
    }
    if (previewState.isError) {
      return Text(
        previewState.errorMessage ?? 'errors.unknown'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor300),
      );
    }

    final preview = previewState.data;
    if (preview == null || preview.slots.isEmpty) {
      return Text(
        'schedule.previewNoSlots'.tr(),
        style: theme.regular14.copyWith(color: theme.textColor200),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: preview.slots
          .map((slot) => _PreviewChip(start: slot.startTime, end: slot.endTime))
          .toList(),
    );
  }
}

class _PreviewChip extends StatelessWidget {
  final String start;
  final String end;

  const _PreviewChip({required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.primaryColor300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$start – $end',
        style: theme.regular14.copyWith(color: theme.primaryColor),
      ),
    );
  }
}
