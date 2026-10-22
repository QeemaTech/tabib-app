import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_slot_entity.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/utils/schedule_display.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/view_model/doctor_schedule_state.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/view_model/doctor_schedule_view_model.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/widgets/schedule_window_row.dart';

class ScheduleEditDaySheet extends StatefulWidget {
  final int dayOfWeek;
  final bool initialActive;
  final List<ScheduleSlotEntity> initialSlots;

  const ScheduleEditDaySheet({
    super.key,
    required this.dayOfWeek,
    required this.initialActive,
    required this.initialSlots,
  });

  @override
  State<ScheduleEditDaySheet> createState() => _ScheduleEditDaySheetState();
}

class _ScheduleEditDaySheetState extends State<ScheduleEditDaySheet> {
  late bool _isActive;
  late List<ScheduleSlotEntity> _slots;

  @override
  void initState() {
    super.initState();
    _isActive = widget.initialActive;
    _slots = widget.initialSlots.isEmpty
        ? [
            const ScheduleSlotEntity(
              startTime: '09:00',
              endTime: '17:00',
              slotDurationMin: 30,
            ),
          ]
        : List<ScheduleSlotEntity>.from(widget.initialSlots);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return BlocListener<DoctorScheduleViewModel, DoctorScheduleState>(
      listenWhen: (p, c) => p.actionState != c.actionState,
      listener: _onActionChanged,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottom),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  ScheduleDisplay.dayKey(widget.dayOfWeek).tr(),
                  style: theme.bold18.copyWith(color: theme.textColor600),
                  textAlign: TextAlign.center,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'schedule.dayActive'.tr(),
                    style: theme.regular14.copyWith(color: theme.textColor600),
                  ),
                  value: _isActive,
                  activeThumbColor: theme.primaryColor,
                  onChanged: (value) => setState(() => _isActive = value),
                ),
                if (_isActive) ..._windows(),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _onSave(context),
                  child: Text(
                    'schedule.save'.tr(),
                    style: theme.bold18.copyWith(
                      fontSize: 14,
                      color: theme.whiteColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context
                      .read<DoctorScheduleViewModel>()
                      .deleteDay(widget.dayOfWeek),
                  child: Text(
                    'schedule.clearDay'.tr(),
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _windows() {
    return [
      ...List.generate(_slots.length, (index) {
        return ScheduleWindowRow(
          slot: _slots[index],
          onChanged: (slot) => setState(() => _slots[index] = slot),
          onRemove: () => setState(() => _slots.removeAt(index)),
        );
      }),
      TextButton.icon(
        onPressed: () {
          setState(() {
            _slots.add(
              const ScheduleSlotEntity(
                startTime: '16:00',
                endTime: '20:00',
                slotDurationMin: 30,
              ),
            );
          });
        },
        icon: const Icon(Icons.add),
        label: Text('schedule.addWindow'.tr()),
      ),
    ];
  }

  void _onActionChanged(BuildContext context, DoctorScheduleState state) {
    final action = state.actionState;
    if (action.isLoaded) {
      CustomToast.show(
        context,
        message: 'schedule.saved'.tr(),
        status: ToastStatus.success,
      );
      context.read<DoctorScheduleViewModel>().resetActionState();
      Navigator.of(context).pop();
    } else if (action.isError) {
      CustomToast.show(
        context,
        message: action.errorMessage ?? 'errors.unknown'.tr(),
        status: ToastStatus.error,
      );
      context.read<DoctorScheduleViewModel>().resetActionState();
    }
  }

  void _onSave(BuildContext context) {
    final errorKey = ScheduleDisplay.validateDaySlots(
      isActive: _isActive,
      slots: _slots,
    );
    if (errorKey != null) {
      CustomToast.show(
        context,
        message: errorKey.tr(),
        status: ToastStatus.error,
      );
      return;
    }
    context.read<DoctorScheduleViewModel>().saveDay(
          dayOfWeek: widget.dayOfWeek,
          isActive: _isActive,
          slots: _isActive ? _slots : const [],
        );
  }
}
