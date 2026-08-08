import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_preview_entity.dart';

DateTime _dateOnly(DateTime date) =>
    DateTime(date.year, date.month, date.day);

class DoctorScheduleState extends Equatable {
  final BaseState<List<ScheduleDayEntity>> scheduleState;
  final BaseState<bool> actionState;
  final BaseState<SchedulePreviewEntity> previewState;
  final DateTime previewDate;

  DoctorScheduleState({
    this.scheduleState = const BaseState(requestState: RequestState.init),
    this.actionState = const BaseState(requestState: RequestState.init),
    this.previewState = const BaseState(requestState: RequestState.init),
    DateTime? previewDate,
  }) : previewDate = _dateOnly(previewDate ?? DateTime.now());

  DoctorScheduleState copyWith({
    BaseState<List<ScheduleDayEntity>>? scheduleState,
    BaseState<bool>? actionState,
    BaseState<SchedulePreviewEntity>? previewState,
    DateTime? previewDate,
  }) {
    return DoctorScheduleState(
      scheduleState: scheduleState ?? this.scheduleState,
      actionState: actionState ?? this.actionState,
      previewState: previewState ?? this.previewState,
      previewDate: previewDate ?? this.previewDate,
    );
  }

  @override
  List<Object?> get props =>
      [scheduleState, actionState, previewState, previewDate];
}
