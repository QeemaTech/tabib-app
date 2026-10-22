import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_slot_entity.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/utils/schedule_display.dart';

class ScheduleWindowRow extends StatelessWidget {
  final ScheduleSlotEntity slot;
  final ValueChanged<ScheduleSlotEntity> onChanged;
  final VoidCallback onRemove;

  const ScheduleWindowRow({
    super.key,
    required this.slot,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _TimeField(
                  label: 'schedule.startTime'.tr(),
                  value: slot.startTime,
                  onTap: () => _pickTime(context, isStart: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TimeField(
                  label: 'schedule.endTime'.tr(),
                  value: slot.endTime,
                  onTap: () => _pickTime(context, isStart: false),
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: Icon(Icons.delete_outline, color: theme.textColor200),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Wrap(
              spacing: 8,
              children: ScheduleDisplay.durations.map((duration) {
                final selected = slot.slotDurationMin == duration;
                return ChoiceChip(
                  label: Text(
                    '$duration${'schedule.minutesShort'.tr()}',
                    style: theme.regular14.copyWith(
                      color: selected
                          ? theme.whiteColor
                          : theme.textColor300,
                    ),
                  ),
                  selected: selected,
                  selectedColor: theme.primaryColor,
                  backgroundColor: theme.whiteColor,
                  onSelected: (_) {
                    onChanged(
                      ScheduleSlotEntity(
                        startTime: slot.startTime,
                        endTime: slot.endTime,
                        slotDurationMin: duration,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(
    BuildContext context, {
    required bool isStart,
  }) async {
    final current = isStart ? slot.startTime : slot.endTime;
    final parts = current.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts.first) ?? 9,
      minute: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
    );
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked == null) return;
    final formatted =
        ScheduleDisplay.formatTimeOfDay(picked.hour, picked.minute);
    onChanged(
      ScheduleSlotEntity(
        startTime: isStart ? formatted : slot.startTime,
        endTime: isStart ? slot.endTime : formatted,
        slotDurationMin: slot.slotDurationMin,
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _TimeField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: theme.regular14.copyWith(color: theme.textColor200),
          filled: true,
          fillColor: theme.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        child: Text(
          value,
          style: theme.regular14.copyWith(color: theme.textColor600),
        ),
      ),
    );
  }
}
