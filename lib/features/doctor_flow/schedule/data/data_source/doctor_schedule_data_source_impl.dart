import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/data_source/doctor_schedule_data_source.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/replace_week_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/update_day_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/doctor_schedule_response.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/schedule_preview_response.dart';

@LazySingleton(as: DoctorScheduleDataSource)
class DoctorScheduleDataSourceImpl implements DoctorScheduleDataSource {
  final ApiClient apiClient;

  DoctorScheduleDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorScheduleResponse>> getSchedule() {
    return executeApi(() => apiClient.getDoctorSchedule());
  }

  @override
  Future<Result<DoctorScheduleResponse>> replaceSchedule(
    ReplaceWeekScheduleRequest request,
  ) {
    return executeApi(() => apiClient.replaceDoctorSchedule(request));
  }

  @override
  Future<Result<SchedulePreviewResponse>> getPreview(String date) {
    return executeApi(() => apiClient.getDoctorSchedulePreview(date: date));
  }

  @override
  Future<Result<DoctorScheduleResponse>> updateDay(
    int dayOfWeek,
    UpdateDayScheduleRequest request,
  ) {
    return executeApi(
      () => apiClient.updateDoctorScheduleDay(dayOfWeek, request),
    );
  }

  @override
  Future<Result<DoctorScheduleResponse>> deleteDay(int dayOfWeek) {
    return executeApi(() => apiClient.deleteDoctorScheduleDay(dayOfWeek));
  }
}
