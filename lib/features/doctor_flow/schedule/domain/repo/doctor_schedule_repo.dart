import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/replace_week_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/update_day_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_day_entity.dart';
import 'package:tabib_app/features/doctor_flow/schedule/domain/entities/schedule_preview_entity.dart';

abstract interface class DoctorScheduleRepo {
  Future<Result<List<ScheduleDayEntity>>> getSchedule();

  Future<Result<List<ScheduleDayEntity>>> replaceSchedule(
    ReplaceWeekScheduleRequest request,
  );

  Future<Result<List<ScheduleDayEntity>>> updateDay(
    int dayOfWeek,
    UpdateDayScheduleRequest request,
  );

  Future<Result<List<ScheduleDayEntity>>> deleteDay(int dayOfWeek);

  Future<Result<SchedulePreviewEntity>> getPreview(String date);
}
