import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_slot_entity.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/view_model/doctor_schedule_view_model.dart';
import 'package:tabib_app/features/doctor_flow/schedule/presentation/widgets/schedule_edit_day_sheet.dart';

Future<void> showScheduleEditDaySheet({
  required BuildContext context,
  required int dayOfWeek,
  required bool isActive,
  required List<ScheduleSlotEntity> slots,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.appTheme.whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => BlocProvider.value(
      value: context.read<DoctorScheduleViewModel>(),
      child: ScheduleEditDaySheet(
        dayOfWeek: dayOfWeek,
        initialActive: isActive,
        initialSlots: slots,
      ),
    ),
  );
}
