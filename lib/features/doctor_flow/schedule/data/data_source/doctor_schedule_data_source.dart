import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/replace_week_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/update_day_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/doctor_schedule_response.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/schedule_preview_response.dart';

abstract interface class DoctorScheduleDataSource {
  Future<Result<DoctorScheduleResponse>> getSchedule();

  Future<Result<DoctorScheduleResponse>> replaceSchedule(
    ReplaceWeekScheduleRequest request,
  );

  Future<Result<SchedulePreviewResponse>> getPreview(String date);

  Future<Result<DoctorScheduleResponse>> updateDay(
    int dayOfWeek,
    UpdateDayScheduleRequest request,
  );

  Future<Result<DoctorScheduleResponse>> deleteDay(int dayOfWeek);
}
