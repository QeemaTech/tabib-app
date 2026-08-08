import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/schedule/data/models/request/update_day_schedule_request.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_preview_entity.dart';
import 'package:tabib_app/features/schedule/domain/entities/schedule_slot_entity.dart';
import 'package:tabib_app/features/schedule/domain/repo/doctor_schedule_repo.dart';
import 'package:tabib_app/features/schedule/presentation/view_model/doctor_schedule_state.dart';

@injectable
class DoctorScheduleViewModel extends Cubit<DoctorScheduleState> {
  final DoctorScheduleRepo doctorScheduleRepo;

  DoctorScheduleViewModel({required this.doctorScheduleRepo})
      : super(DoctorScheduleState());

  Future<void> loadSchedule({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(scheduleState: BaseState.loading()));
    }

    final result = await doctorScheduleRepo.getSchedule();
    switch (result) {
      case Success<List<ScheduleDayEntity>>():
        emit(
          state.copyWith(scheduleState: BaseState.loaded(result.data)),
        );
      case Failure<List<ScheduleDayEntity>>():
        emit(
          state.copyWith(
            scheduleState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> saveDay({
    required int dayOfWeek,
    required bool isActive,
    required List<ScheduleSlotEntity> slots,
  }) async {
    emit(state.copyWith(actionState: BaseState.loading()));

    final request = UpdateDayScheduleRequest(
      isActive: isActive,
      slots: slots
          .map(
            (slot) => ScheduleSlotRequest(
              startTime: slot.startTime,
              endTime: slot.endTime,
              slotDurationMin: slot.slotDurationMin,
            ),
          )
          .toList(),
    );

    final result = await doctorScheduleRepo.updateDay(dayOfWeek, request);
    switch (result) {
      case Success<List<ScheduleDayEntity>>():
        emit(
          state.copyWith(
            scheduleState: BaseState.loaded(result.data),
            actionState: BaseState.loaded(true),
          ),
        );
      case Failure<List<ScheduleDayEntity>>():
        emit(
          state.copyWith(actionState: BaseState.error(result.errorMessage)),
        );
    }
  }

  Future<void> deleteDay(int dayOfWeek) async {
    emit(state.copyWith(actionState: BaseState.loading()));

    final result = await doctorScheduleRepo.deleteDay(dayOfWeek);
    switch (result) {
      case Success<List<ScheduleDayEntity>>():
        emit(
          state.copyWith(
            scheduleState: BaseState.loaded(result.data),
            actionState: BaseState.loaded(true),
          ),
        );
      case Failure<List<ScheduleDayEntity>>():
        emit(
          state.copyWith(actionState: BaseState.error(result.errorMessage)),
        );
    }
  }

  void onPreviewDateSelected(DateTime date) {
    final dateOnly = DateTime(date.year, date.month, date.day);
    if (dateOnly == state.previewDate) return;
    emit(state.copyWith(previewDate: dateOnly));
  }

  Future<void> loadPreview() async {
    emit(state.copyWith(previewState: BaseState.loading()));

    final date = DateFormat('yyyy-MM-dd').format(state.previewDate);
    final result = await doctorScheduleRepo.getPreview(date);
    switch (result) {
      case Success<SchedulePreviewEntity>():
        emit(state.copyWith(previewState: BaseState.loaded(result.data)));
      case Failure<SchedulePreviewEntity>():
        emit(
          state.copyWith(
            previewState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void resetActionState() {
    emit(
      state.copyWith(
        actionState: const BaseState(requestState: RequestState.init),
      ),
    );
  }

  Future<void> retry() => loadSchedule();
}
